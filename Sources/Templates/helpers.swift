import SourceryRuntime

extension String {
    static let newLine = "\n"
}

extension Annotated {

    var isAutoStubbable: Bool {
        annotations["AutoStubbable"] as? Int == 1
    }

    var isAutoMockable: Bool {
        annotations["AutoMockable"] as? Int == 1
    }

    var isFinal: Bool {
        annotations["final"] as? Int == 1
    }
}

extension Variable {
    var hasDefaultValue: Bool {
        defaultValue != nil
    }
}

extension AttributeList {

    var isEscaping: Bool {
        contains(where: { $0.key == "escaping" })
    }
}

extension MethodParameter {

    var settableType: String {
        var type = typeAttributes.isEscaping ? unwrappedTypeName : typeName.asSource
        if isVariadic {
            type = "[\(type)]"
        }
        return type
    }
}

func generateDefaultValue(type: Type?, typeName: TypeName, includeComplexType: Bool) -> String {
    if typeName.isOptional && !typeName.isImplicitlyUnwrappedOptional {
        return "nil"
    }
    if typeName.isArray {
        return "[]"
    }
    if typeName.isDictionary {
        return "[:]"
    }
    if typeName.isTuple, let tuple = typeName.tuple {
        let combinedElements = tuple.elements.map { generateDefaultValue(type: $0.type, typeName: $0.typeName, includeComplexType: includeComplexType) }.joined(separator: ", ")
        return "(\(combinedElements))"
    }
    if includeComplexType, let enumType = type as? Enum, let firstCase = enumType.cases.first {
        return generateEnumDefaultValue(enum: enumType, firstCase: firstCase, includeComplexType: includeComplexType)
    }
    if typeName.isClosure, let closure = typeName.closure {
        return "{ \(generateDefaultValue(type: closure.returnType, typeName: closure.returnTypeName, includeComplexType: includeComplexType)) } "
    }

    switch typeName.unwrappedTypeName {
    case "String", "Character": return "\"\""
    case "Int", "Double", "TimeInterval", "CGFloat", "Float": return "0"
    case "Bool": return "false"
    case "URL": return "URL(fileURLWithPath: \"\")"
    case "UIApplication": return ".shared" // UIApplication is special
    default:
        if includeComplexType {
            if type?.isAutoStubbable == true {
                return "\(generateTypeName(typeName: typeName, type: type)).stub()"
            } else if type?.isAutoMockable == true {
                return "Default\(typeName.unwrappedTypeName)Mock()"
            }

            return ".init()"
        }
        return ""
    }
}

func generateEnumDefaultValue(enum: Enum, firstCase: EnumCase, includeComplexType: Bool) -> String {
    guard firstCase.hasAssociatedValue else {
        return ".\(firstCase.name)"
    }
    let associatedValue = firstCase.associatedValues.map { value in
        let defaultValue = value.defaultValue ?? generateDefaultValue(type: value.type, typeName: value.typeName, includeComplexType: includeComplexType)
        return [value.localName, defaultValue].compactMap { $0 }.joined(separator: ": ")
    }.joined(separator: ", ")
    return ".\(firstCase.name)(\(associatedValue))"
}

func generateTypeName(typeName: TypeName, type: Type?) -> String {
    let addition = (typeName.isOptional && !typeName.isImplicitlyUnwrappedOptional) ? "?" : ""
    if let dictionaryType = typeName.dictionary {
        return dictionaryType.name + addition
    }
    if let arrayType = typeName.array {
        var bracketCount = 1
        var elementTypeName = arrayType.elementTypeName
        var elementType = arrayType.elementType?.name ?? arrayType.elementTypeName.name

        // If the type of Element is an array, loop the nested array recursively
        while let innerArrayType = elementTypeName.array {
            bracketCount += 1
            elementTypeName = innerArrayType.elementTypeName
            elementType = innerArrayType.elementType?.name ?? innerArrayType.elementTypeName.name
        }

        let openBrackets = String(repeating: "[", count: bracketCount)
        let closingBrackets = String(repeating: "]", count: bracketCount)

        let resultType = openBrackets + elementType + closingBrackets
        return resultType + addition
    }

    return (type?.name ?? typeName.unwrappedTypeName) + addition
}

func stubMethodName(index: Int, count: Int) -> String {
    count > 1 ? "stub\(index)" : "stub"
}

func mockInheritedTypes(protocolType: Protocol) -> String {
    let inherited = protocolType.genericRequirements.map { "\($0.rightType.typeName.name), " }.joined()
    return "\(inherited)\(protocolType.name)"
}

func mockMethodFunctionDeclaration(method: Method, type: Type) -> String {
    "func \(method.name)\(method.isAsync ? " async" : "")\(method.throws ? " throws" : "")\(mockMethodReturnType(method: method, type: type)) {"
}

func mockMethodReturnType(method: Method, type: Type) -> String {
    guard !method.returnTypeName.isVoid else { return "" }
    if method.returnTypeName.name == "Self" {
        return " -> Default\(type.name)Mock"
    }
    return " -> \(method.returnTypeName.name)"
}

func mockMethodReceivedParameters(methodName: String, method: Method) -> String {
    var ret: [String] = []
    ret.append("defer { invoked\(methodName)Expectation.fulfill() }")
    if method.throws {
        ret.append("if let error = stubbed\(methodName)ThrowableError {")
        ret.append("    throw error")
        ret.append("}")
    }
    if !method.isInitializer {
        ret.append("invoked\(methodName) = true")
        ret.append("invoked\(methodName)Count += 1")
    }
    let mockableParameters = method.parameters.filter { !$0.typeName.isClosure || $0.typeAttributes.isEscaping }
    if !mockableParameters.isEmpty {
        var parameters = mockableParameters.map { "\($0.name): \($0.name)" }.joined(separator: ", ")
        if mockableParameters.count == 1 {
            parameters.append(", ()")
        }
        ret.append("invoked\(methodName)Parameters = (\(parameters))")
        ret.append("invoked\(methodName)ParametersList.append((\(parameters)))")
    }
    method.parameters.filter { $0.typeName.isClosure }.forEach { parameter in
        guard let closure = parameter.typeName.closure else { return }
        if closure.parameters.count == 0 {
            ret.append("if shouldInvoke\(methodName)\(parameter.name.capitalizingFirstLetter()) {")
            ret.append("    \(mockClosureInvocation(closure: closure, parameter: parameter))")
            ret.append("}")
        } else {
            ret.append("if let result = stubbed\(methodName)\(parameter.name.capitalizingFirstLetter())Result {")
            ret.append("    \(mockClosureInvocation(closure: closure, parameter: parameter))")
            ret.append("}")
        }
    }
    if !method.returnTypeName.isVoid && !method.isInitializer {
        ret.append("return stubbed\(methodName)Result")
    }
    return ret.map { $0.addingIndent(count: 2) }.joined(separator: "\n")
}

func mockClosureInvocation(closure: ClosureType, parameter: MethodParameter) -> String {
    let invocations: String
    if closure.parameters.count == 1, let closureParameter = closure.parameters.first, !closureParameter.typeName.isOptional {
        invocations = "result"
    } else {
        invocations = (0..<closure.parameters.count).map { "result.\($0)" }.joined(separator: ", ")
    }
    return "\(closure.isAsync ? "await " : "")\(closure.returnTypeName.isVoid ? "" : "_ = ")\(parameter.name)\(parameter.typeName.isOptional ? "?" : "")(\(invocations))"
}

func mockMethodAttributes(method: Method) -> String {
    method.attributes.flatMap(\.value).map { "\($0.description.addingIndent())\n" }.joined()
}

func mockStubParameters(methodName: String, method: Method, type: Type) -> String {
    var ret: [String] = []
    if method.throws {
        ret.append("var stubbed\(methodName)ThrowableError: Error?")
    }
    if !method.isInitializer {
        ret.append("var invoked\(methodName) = false")
        ret.append("var invoked\(methodName)Count = 0")
    }
    let mockableParameters = method.parameters.filter { !$0.typeName.isClosure || $0.typeAttributes.isEscaping }
    if !mockableParameters.isEmpty {
        var parameters = mockableParameters.map { "\($0.name): \($0.settableType)" }.joined(separator: ", ")
        if mockableParameters.count == 1 {
            parameters.append(", Void")
        }
        ret.append("var invoked\(methodName)Parameters: (\(parameters))?")
        ret.append("var invoked\(methodName)ParametersList: [(\(parameters))] = []")
    }
    method.parameters.filter { $0.typeName.isClosure }.forEach { parameter in
        guard let closure = parameter.typeName.closure else { return }
        if closure.parameters.count == 0 {
            ret.append("var shouldInvoke\(methodName)\(parameter.name.capitalizingFirstLetter()) = false")
        } else if closure.parameters.count == 1, let closureParameter = closure.parameters.first, !closureParameter.typeName.isOptional {
            ret.append("var stubbed\(methodName)\(parameter.name.capitalizingFirstLetter())Result: \(closureParameter.typeName.name)?")
        } else {
            var parameters = closure.parameters.map { $0.typeName.name }.joined(separator: ", ")
            if closure.parameters.count == 1 {
                parameters.append(", Void")
            }
            ret.append("var stubbed\(methodName)\(parameter.name.capitalizingFirstLetter())Result: (\(parameters))?")
        }
    }
    if !method.returnTypeName.isVoid && !method.isInitializer {
        let returnType = method.returnTypeName.name == "Self" ? "Default\(type.name)Mock" : method.returnTypeName.name
        let defaultValue = generateDefaultValue(type: method.returnType, typeName: method.returnTypeName, includeComplexType: false)
        let nonOptionalSignature = defaultValue.isEmpty ? "!" : "! = \(defaultValue)"
        ret.append("var stubbed\(methodName)Result: \(returnType)\(method.isOptionalReturnType ? "" : nonOptionalSignature)")
    }
    ret.append("var invoked\(methodName)Expectation = XCTestExpectation(description: \"\\(#function) expectation\")")
    return ret.map { $0.addingIndent() }.joined(separator: "\n")
}

var takenNames: Set<String> = []

func generateMethodName(method: Method, allMethods: [Method]) -> String {
    let name = method.callName.capitalizingFirstLetter()
    let duplicateMethods = allMethods.filter { $0.callName == method.callName && $0.parameters.count == method.parameters.count }
    guard duplicateMethods.count > 1 else {
        var newName = name
        var index = 0
        while takenNames.contains(newName) {
            newName = method.makeNameWithParameterNames(index: index)
            index += 1
        }
        takenNames.insert(newName)
        return newName
    }
    // since there are duplicates we must make sure any unique methods with the same name but with more (equal) parameters will skip
    // names with less parameters than these duplicates starting with the method name itself
    takenNames.insert(name)
    // first try to make a unique name on parameter names
    for index in (0..<method.parameters.count) {
        let newName = method.makeNameWithParameterNames(index: index)
        takenNames.insert(newName)
        if duplicateMethods.filter({ $0.makeNameWithParameterNames(index: index) == newName }).count == 1 {
            return newName
        }
    }
    // then try to add the type to make a unique name on parameter names
    for index in (0..<method.parameters.count) {
        let newName = method.makeNameWithParameterNamesAndTypes(index: index)
        if duplicateMethods.filter({ $0.makeNameWithParameterNamesAndTypes(index: index) == newName }).count == 1 {
            return newName.replacingOccurrences(of: ".", with: "")
        }
    }
    fatalError("Something terrible happened")
}

func generateStubbableInit(objectType: Type, variables: [Variable]) -> String {
    guard !variables.isEmpty else {
        return "\(objectType.name)()"
    }

    let initVariables = variables.filter { !$0.isImplicitlyUnwrappedOptional && !$0.hasDefaultValue }

    return generateStubbableInit(objectType: objectType, parameterNames: initVariables.map { $0.name })
}

func generateStubbableInit(objectType: Type, parameterNames: [String]) -> String {
    let implicitlyUnwrappedVariables = objectType.storedVariables.filter { $0.isImplicitlyUnwrappedOptional }
    let containsImplicitlyUnwrappedOptionals = !implicitlyUnwrappedVariables.isEmpty

    guard !parameterNames.isEmpty || containsImplicitlyUnwrappedOptionals else {
        return "\(objectType.name)()"
    }

    var objectInit: String = containsImplicitlyUnwrappedOptionals ? "let object = \(objectType.name)(" : "\(objectType.name)("

    if parameterNames.isEmpty {
        objectInit.append(")")
    } else {
        parameterNames.enumerated().forEach { index, element in
            let isLastElement = index + 1 ==  parameterNames.count
            let suffix: String = isLastElement ? "" : ","
            let line = "\(element): \(element)\(suffix)".addingIndent(count: 3)
            objectInit.append(contentsOf: "\n\(line)")

            if isLastElement {
                objectInit.append(contentsOf: "\n")
                objectInit.append(contentsOf: ")".addingIndent(count: 2))
            }
        }
    }

    if containsImplicitlyUnwrappedOptionals {
        for variable in implicitlyUnwrappedVariables {
            objectInit.append(contentsOf: "\n")
            objectInit.append(contentsOf: "object.\(variable.name) = \(variable.name)".addingIndent(count: 2))
        }
        objectInit.append(contentsOf: "\n")
        objectInit.append(contentsOf: "return object".addingIndent(count: 2))
    }

    return objectInit
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    func addingIndent(count: Int = 1) -> String {
        Array(repeating: "    ", count: count).joined() + self
    }
}

extension Method {
    func makeNameWithParameterNames(index: Int) -> String {
        guard index < parameters.count else { fatalError("Something terrible happened") }
        return callName.capitalizingFirstLetter() + parameters[0...index].compactMap { ($0.argumentLabel ?? $0.name).capitalizingFirstLetter() }.joined()
    }
    func makeNameWithParameterNamesAndTypes(index: Int) -> String {
        guard index < parameters.count else { fatalError("Something terrible happened") }
        let newName = callName.capitalizingFirstLetter() + parameters[0...index].map { parameter in
            return (parameter.argumentLabel?.capitalizingFirstLetter() ?? "") + parameter.maskedTypeName.capitalizingFirstLetter()
        }.joined()
        return newName + parameters[(index + 1)..<parameters.count].compactMap { $0.argumentLabel?.capitalizingFirstLetter() }.joined()
    }
}

extension Array where Element == Method {

    func sorted() -> Self {
        sorted { one, two in
            if one.callName == two.callName {
                return one.parameters.count < two.parameters.count
            } else {
                return one.callName < two.callName
            }
        }
    }
}

extension MethodParameter {
    var maskedTypeName: String {
        if let arrayElementType = typeName.array?.elementTypeName.name {
            return arrayElementType + "s"
        }
        return unwrappedTypeName
    }
}
