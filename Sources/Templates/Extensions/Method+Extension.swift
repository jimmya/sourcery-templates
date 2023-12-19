import SourceryRuntime

extension Method {
    
    /// The preferred property when you need the method name including generics and parameters
    ///
    /// No Sourcery Method property supports optional opaque types, this property does
    ///
    /// - Returns: `"foo<T>(object: (any Protocol)?)"`
    var methodName: String {
        "\(shortName)(\(methodParameters))"
    }

    /// Concatenates all function parameters in a string
    var methodParameters: String {
        parameters.map { parameter in
            let parameterName = parameter.name

            if parameter.typeName.isOpaqueType {
                return "\(parameterName): \(parameter.typeName.withWrappedOptionalIfNeeded())"
            } else if let closure = parameter.typeName.closure {
                return closure.signature(fromMethodParameter: parameter)
            }

            return parameter.asSource

        }.joined(separator: ", ")
    }

    /// Generate mock for a method
    /// - Parameters:
    ///   - takenNames: Names that already have mocks, used to avoid collisions when methods have similar signatures
    ///   - allMethods: List containing all methods in the type, used to avoid collisions
    ///   - type: The type this mock is generated for
    /// - Returns: List of lines containing the mock
    func generateMock(takenNames: inout Set<String>, allMethods: [Method], in type: Type, types: Types, accessLevel: String, annotations: Annotations) -> [String] {
        let methodName = generateMockName(allMethods: allMethods, takenNames: &takenNames).replacingOccurrences(of: "?", with: "")
        // Parameters captured or returned when method is called
        var lines = mockStubParameters(name: methodName, type: type, types: types, accessLevel: accessLevel, annotations: annotations)
        // Attributes `@objc` etc.
        lines.append(mockAttributes())
        // Function declaration `func something() {`
        lines.append(mockFunctionDeclaration(type: type, annotations: annotations).indent())
        // Filling or captured variables or returning stubbed values when method is called
        lines.append(contentsOf: mockReceivedParameters(methodName: methodName))
        // Close method
        lines.append("}".indent())
        return lines
    }

    /// Extract generics from a method e.g. `func foo<T: String>` -> `[("T", "String")]`
    var generics: [(name: String, constraints: String?)] {
        guard let combinedGenerics = shortName.matches(for: "<([^<>]*)>")
            .first?
            .replacingOccurrences(of: ">", with: "")
            .replacingOccurrences(of: "<", with: "")
        else {
            return []
        }
        let generics = combinedGenerics.components(separatedBy: ",")
        return generics.map {
            let components = $0.components(separatedBy: ":")
            if components.count == 2 {
                return (components[0].trimmed, components[1].trimmed)
            }
            if let returnTypeGenericClause {
                let components = returnTypeGenericClause.components(separatedBy: ",")
                if
                    let matchingComponent = components.first(where: { $0.hasPrefix($0.trimmed) }),
                    let clause = matchingComponent.components(separatedBy: ":").last
                {
                    return ($0.trimmed, clause.trimmed)
                }
            }
            return ($0.trimmed, nil)
        }
    }

    var sanitizedReturnTypeName: String {
        returnTypeName.name.components(separatedBy: " where ").first ?? returnTypeName.name
    }

    var returnTypeGenericClause: String? {
        let components = returnTypeName.name.components(separatedBy: " where ")
        guard components.count == 2 else {
            return nil
        }
        return components[1]
    }
}

private extension Method {

    /// Generates a unique name to store method parameters or stub values `var invokedFoo` etc.
    ///
    /// - Parameters:
    ///   - allMethods: All the method declared in the type
    ///   - takenNames: Set of names that are already taken
    /// - Returns: A unique mock name
    ///
    /// Ensures the name is unique when methods have duplicate names e.g. `func foo()` `func foo(bar: Int`
    /// The example above will generate `Foo` and `FooBar` as mock names.
    func generateMockName(allMethods: [Method], takenNames: inout Set<String>) -> String {
        let name = callName.replacingOccurrences(of: "?", with: "").capitalizingFirstLetter()
        let duplicateMethods = allMethods.filter { $0.callName == callName && $0.parameters.count == parameters.count && $0.generics.count == generics.count }
        guard duplicateMethods.count > 1 else {
            var newName = name
            var index = 0
            while takenNames.contains(newName) {
                newName = makeNameWithParameterNames(index: index)
                index += 1
            }
            takenNames.insert(newName)
            return newName
        }
        // since there are duplicates we must make sure any unique methods with the same name but with more (equal) parameters will skip
        // names with less parameters than these duplicates starting with the method name itself
        takenNames.insert(name)
        // first try to make a unique name on parameter names
        for index in (0..<parameters.count) {
            let newName = makeNameWithParameterNames(index: index)
            takenNames.insert(newName)
            if duplicateMethods.filter({ $0.makeNameWithParameterNames(index: index) == newName }).count == 1 {
                return newName
            }
        }
        // then try to add the type to make a unique name on parameter names
        for index in (0..<parameters.count) {
            let newName = makeNameWithParameterNamesAndTypes(index: index)
            if duplicateMethods.filter({ $0.makeNameWithParameterNamesAndTypes(index: index) == newName }).count == 1 {
                return newName.replacingOccurrences(of: ".", with: "")
            }
        }
        for index in (0..<parameters.count) {
            let newName = makeNameWithParameterNamesTypesAndGenerics(index: index)
            if duplicateMethods.filter({ $0.makeNameWithParameterNamesTypesAndGenerics(index: index) == newName }).count == 1 {
                return newName.replacingOccurrences(of: ".", with: "")
            }
        }
        fatalError("Something terrible happened")
    }

    /// Generates parameters that are captured or returned
    /// - Parameters:
    ///   - name: Unique name of the method to generate stub parameters for
    ///   - type: Used to construct a return type in case return type is `Self`
    /// - Returns: List of lines containing the generated parameters
    func mockStubParameters(name: String, type: Type, types: Types, accessLevel: String, annotations: Annotations) -> [String] {
        var lines: [String] = []
        if self.throws {
            lines.append("\(accessLevel) var stubbed\(name)ThrowableError: Error?")
        }
        if !isInitializer {
            lines.append("\(accessLevel) var invoked\(name): Bool { invoked\(name)Count > 0 }")
            lines.append("\(accessLevel) var invoked\(name)Count = 0")
        }
        let mockableParameters = parameters.filter { !$0.typeName.isClosure || $0.typeAttributes.isEscaping }
        if !mockableParameters.isEmpty {
            var parameters = mockableParameters.map { "\($0.name): \($0.settableType(method: self))" }.joined(separator: ", ")
            if mockableParameters.count == 1 {
                parameters.append(", Void")
            }
            lines.append("\(accessLevel) var invoked\(name)Parameters: (\(parameters))?")
            lines.append("\(accessLevel) var invoked\(name)ParametersList: [(\(parameters))] = []")
        }
        parameters.filter { $0.typeName.isClosure }.forEach { parameter in
            guard let closure = parameter.typeName.closure else { return }

            if closure.parameters.count == 0 {
                lines.append("\(accessLevel) var shouldInvoke\(name)\(parameter.name.capitalizingFirstLetter()) = false")
            } else if 
                closure.parameters.count == 1,
                let closureParameter = closure.parameters.first,
                !closureParameter.typeName.isOptional
            {
                let type = closureParameter.typeName.withWrappedOptionalIfNeeded()
                lines.append("\(accessLevel) var stubbed\(name)\(parameter.name.capitalizingFirstLetter())Result: \(type)?")
            } else {
                var parameters = closure.parameters.map { $0.typeName.withWrappedOptionalIfNeeded() }.joined(separator: ", ")
                if closure.parameters.count == 1 {
                    parameters.append(", Void")
                }
                lines.append("\(accessLevel) var stubbed\(name)\(parameter.name.capitalizingFirstLetter())Result: (\(parameters))?")
            }
        }
        if !returnTypeName.isVoid && !isInitializer {
            // Stored property cannot have covariant `Self` type
            let mockName = annotations.mockName(typeName: type.name)
            let returnTypeNameString = returnTypeName.name == "Self" ? "\(mockName)" : sanitizedReturnTypeName

            var resultType: String

            if let generic = generics.first(where: { $0.name == returnTypeNameString }) {
                let genericConstraint = generic.constraints ?? "Any"
                resultType = genericConstraint
            } else if returnTypeName.isOpaqueType {
                resultType = returnTypeName.isOptional ? returnTypeName.withWrappedOptionalIfNeeded() : "(\(returnTypeName))"
            } else {
                resultType = returnTypeNameString
            }

            resultType += isOptionalReturnType ? "" : "!"

            lines.append("\(accessLevel) var stubbed\(name)Result: \(resultType)")
        }
        if !isInitializer { // Expectations aren't possible in the initializer
            lines.append("\(accessLevel) var invoked\(name)Expectation = XCTestExpectation(description: \"\\(#function) expectation\")")
        }
        return lines.map { $0.indent() }
    }

    /// Attributes of method, e.g. `@objc` etc.
    func mockAttributes() -> String {
        attributes.flatMap(\.value).map { "\($0.description.indent())" + .newLine }.joined()
    }

    /// Generates filling captured variables, calling closures or returning stub value in a function
    /// - Parameter methodName: Unique name of the method to generate stub parameters for
    /// - Returns: List of lines containing the generated code
    func mockReceivedParameters(methodName: String) -> [String] {
        var lines: [String] = []
        if !isInitializer {
            // Call expectation in defer, only makes sense in a non-init method.
            lines.append("defer { invoked\(methodName)Expectation.fulfill() }")
        }
        if !isInitializer {
            lines.append("invoked\(methodName)Count += 1")
        }
        let mockableParameters = parameters.filter { !$0.typeName.isClosure || $0.typeAttributes.isEscaping }
        if !mockableParameters.isEmpty {
            var parameters = mockableParameters.map { "\($0.name): \($0.name)" }.joined(separator: ", ")
            if mockableParameters.count == 1 {
                parameters.append(", ()")
            }
            lines.append("invoked\(methodName)Parameters = (\(parameters))")
            lines.append("invoked\(methodName)ParametersList.append((\(parameters)))")
        }
        parameters.filter { $0.typeName.isClosure }.forEach { parameter in
            guard let closure = parameter.typeName.closure else { return }
            if closure.parameters.count == 0 {
                lines.append("if shouldInvoke\(methodName)\(parameter.name.capitalizingFirstLetter()) {")
                lines.append("    \(mockClosureInvocation(closure: closure, parameter: parameter))")
                lines.append("}")
            } else {
                lines.append("if let result = stubbed\(methodName)\(parameter.name.capitalizingFirstLetter())Result {")
                lines.append("    \(mockClosureInvocation(closure: closure, parameter: parameter))")
                lines.append("}")
            }
        }
        if self.throws {
            lines.append("if let error = stubbed\(methodName)ThrowableError {")
            lines.append("    throw error")
            lines.append("}")
        }
        if !returnTypeName.isVoid && !isInitializer {
            if generics.contains(where: { $0.name == sanitizedReturnTypeName }) {
                lines.append("return stubbed\(methodName)Result as! \(sanitizedReturnTypeName)")
            } else {
                lines.append("return stubbed\(methodName)Result")
            }
        }
        return lines.map { $0.indent(level: 2) }
    }


    /// Generate function declaration: `func doSomething() async throws -> String`
    /// - Parameter type: Used to construct a return type in case return type is `Self`
    /// - Returns: Generated function declaration
    func mockFunctionDeclaration(type: Type, annotations: Annotations) -> String {
        let parts: [String?]
        if isInitializer {
            parts = [
                type.accessLevel,
                "required",
                name.replacingOccurrences(of: "?", with: ""), // Remove `?` from failable initialisers.
                "{",
            ]
        } else {
            parts = [
                type.accessLevel,
                "func",
                methodName,
                isAsync ? "async" : nil,
                self.throws ? "throws" : nil,
                mockReturnType(type: type, annotations: annotations),
                "{",
            ]
        }
        return parts.compactMap { $0 }.joined(separator: " ")
    }
}

private extension Method {
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

    func makeNameWithParameterNamesTypesAndGenerics(index: Int) -> String {
        guard index < parameters.count else { fatalError("Something terrible happened") }
        var newName = callName.capitalizingFirstLetter() + parameters[0...index].map { parameter in
            return (parameter.argumentLabel?.capitalizingFirstLetter() ?? "") + parameter.maskedTypeName.capitalizingFirstLetter()
        }.joined()
        newName = newName + parameters[(index + 1)..<parameters.count].compactMap { $0.argumentLabel?.capitalizingFirstLetter() }.joined()
        newName = newName + generics.map(\.name).joined()
        return newName
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

    func mockReturnType(type: Type, annotations: Annotations) -> String? {
        guard !returnTypeName.isVoid else { return nil }

        // We have to return a concrete type instead of `Self`
        if returnTypeName.name == "Self" {
            let mockName = annotations.mockName(typeName: type.name)
            return "-> \(mockName)"
        } else if returnTypeName.isOpaqueType && returnTypeName.isOptional {
            return "-> \(returnTypeName.withWrappedOptionalIfNeeded())"
        }

        return "-> \(returnTypeName.name)"
    }
}

private extension MethodParameter {
    var maskedTypeName: String {
        if let arrayElementType = typeName.array?.elementTypeName.name {
            return arrayElementType + "s"
        }
        return unwrappedTypeName
    }
}
