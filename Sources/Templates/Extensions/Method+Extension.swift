import SourceryRuntime

extension Method {
    func generateMock(takenNames: inout Set<String>, allMethods: [Method], in type: Type) -> [String] {
        let methodName = generateMockName(allMethods: allMethods, takenNames: &takenNames).replacingOccurrences(of: "?", with: "")
        var lines = [
            mockStubParameters(name: methodName, type: type),
            mockAttributes(),
        ]
        if isInitializer {
            lines.append(contentsOf: [
                "required \(name.replacingOccurrences(of: "?", with: "")) {".addingIndent(),
                mockReceivedParameters(methodName: methodName),
                "}".addingIndent(),
            ])
        } else {
            lines.append(contentsOf: [
                mockFunctionDeclaration(type: type).addingIndent(),
                mockReceivedParameters(methodName: methodName),
                "}".addingIndent(),
            ])
        }
        return lines
    }
}

private extension Method {
    func generateMockName(allMethods: [Method], takenNames: inout Set<String>) -> String {
        let name = callName.capitalizingFirstLetter()
        let duplicateMethods = allMethods.filter { $0.callName == callName && $0.parameters.count == parameters.count }
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
        fatalError("Something terrible happened")
    }

    func mockStubParameters(name: String, type: Type) -> String {
        var ret: [String] = []
        if self.throws {
            ret.append("var stubbed\(name)ThrowableError: Error?")
        }
        if !isInitializer {
            ret.append("var invoked\(name) = false")
            ret.append("var invoked\(name)Count = 0")
        }
        let mockableParameters = parameters.filter { !$0.typeName.isClosure || $0.typeAttributes.isEscaping }
        if !mockableParameters.isEmpty {
            var parameters = mockableParameters.map { "\($0.name): \($0.settableType)" }.joined(separator: ", ")
            if mockableParameters.count == 1 {
                parameters.append(", Void")
            }
            ret.append("var invoked\(name)Parameters: (\(parameters))?")
            ret.append("var invoked\(name)ParametersList: [(\(parameters))] = []")
        }
        parameters.filter { $0.typeName.isClosure }.forEach { parameter in
            guard let closure = parameter.typeName.closure else { return }
            if closure.parameters.count == 0 {
                ret.append("var shouldInvoke\(name)\(parameter.name.capitalizingFirstLetter()) = false")
            } else if closure.parameters.count == 1, let closureParameter = closure.parameters.first, !closureParameter.typeName.isOptional {
                ret.append("var stubbed\(name)\(parameter.name.capitalizingFirstLetter())Result: \(closureParameter.typeName.name)?")
            } else {
                var parameters = closure.parameters.map { $0.typeName.name }.joined(separator: ", ")
                if closure.parameters.count == 1 {
                    parameters.append(", Void")
                }
                ret.append("var stubbed\(name)\(parameter.name.capitalizingFirstLetter())Result: (\(parameters))?")
            }
        }
        if !returnTypeName.isVoid && !isInitializer {
            let returnTypeNameString = returnTypeName.name == "Self" ? "Default\(type.name)Mock" : returnTypeName.name
            let defaultValue = returnTypeName.generateDefaultValue(type: returnType, includeComplexType: false)
            let nonOptionalSignature = defaultValue.isEmpty ? "!" : "! = \(defaultValue)"
            ret.append("var stubbed\(name)Result: \(returnTypeNameString)\(isOptionalReturnType ? "" : nonOptionalSignature)")
        }
        ret.append("var invoked\(name)Expectation = XCTestExpectation(description: \"\\(#function) expectation\")")
        return ret.map { $0.addingIndent() }.joined(separator: "\n")
    }

    func mockAttributes() -> String {
        attributes.flatMap(\.value).map { "\($0.description.addingIndent())\n" }.joined()
    }

    func mockReceivedParameters(methodName: String) -> String {
        var ret: [String] = []
        ret.append("defer { invoked\(methodName)Expectation.fulfill() }")
        if self.throws {
            ret.append("if let error = stubbed\(methodName)ThrowableError {")
            ret.append("    throw error")
            ret.append("}")
        }
        if !isInitializer {
            ret.append("invoked\(methodName) = true")
            ret.append("invoked\(methodName)Count += 1")
        }
        let mockableParameters = parameters.filter { !$0.typeName.isClosure || $0.typeAttributes.isEscaping }
        if !mockableParameters.isEmpty {
            var parameters = mockableParameters.map { "\($0.name): \($0.name)" }.joined(separator: ", ")
            if mockableParameters.count == 1 {
                parameters.append(", ()")
            }
            ret.append("invoked\(methodName)Parameters = (\(parameters))")
            ret.append("invoked\(methodName)ParametersList.append((\(parameters)))")
        }
        parameters.filter { $0.typeName.isClosure }.forEach { parameter in
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
        if !returnTypeName.isVoid && !isInitializer {
            ret.append("return stubbed\(methodName)Result")
        }
        return ret.map { $0.addingIndent(count: 2) }.joined(separator: "\n")
    }

    func mockFunctionDeclaration(type: Type) -> String {
        "func \(name)\(isAsync ? " async" : "")\(self.throws ? " throws" : "")\(mockReturnType(type: type)) {"
    }

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

    func mockClosureInvocation(closure: ClosureType, parameter: MethodParameter) -> String {
        let invocations: String
        if closure.parameters.count == 1, let closureParameter = closure.parameters.first, !closureParameter.typeName.isOptional {
            invocations = "result"
        } else {
            invocations = (0..<closure.parameters.count).map { "result.\($0)" }.joined(separator: ", ")
        }
        return "\(closure.isAsync ? "await " : "")\(closure.returnTypeName.isVoid ? "" : "_ = ")\(parameter.name)\(parameter.typeName.isOptional ? "?" : "")(\(invocations))"
    }

    func mockReturnType(type: Type) -> String {
        guard !returnTypeName.isVoid else { return "" }
        if returnTypeName.name == "Self" {
            return " -> Default\(type.name)Mock"
        }
        return " -> \(returnTypeName.name)"
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

private extension MethodParameter {
    var maskedTypeName: String {
        if let arrayElementType = typeName.array?.elementTypeName.name {
            return arrayElementType + "s"
        }
        return unwrappedTypeName
    }
}
