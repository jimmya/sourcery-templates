import SourceryRuntime

extension Type {
    var initMethods: [Method] {
        methods.filter { ($0.isInitializer || $0.isFailableInitializer) && !$0.isConvenienceInitializer }
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

func generateEnumDefaultValue(enum: Enum, firstCase: EnumCase, includeComplexType: Bool) -> String {
    guard firstCase.hasAssociatedValue else {
        return ".\(firstCase.name)"
    }
    let associatedValue = firstCase.associatedValues.map { value in
        let defaultValue = value.defaultValue ?? value.typeName.generateDefaultValue(type: value.type, includeComplexType: includeComplexType)
        return [value.localName, defaultValue].compactMap { $0 }.joined(separator: ": ")
    }.joined(separator: ", ")
    return ".\(firstCase.name)(\(associatedValue))"
}

func stubMethodName(index: Int, count: Int) -> String {
    count > 1 ? "stub\(index)" : "stub"
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
