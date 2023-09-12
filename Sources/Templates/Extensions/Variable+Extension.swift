import SourceryRuntime

extension Variable {
    var hasDefaultValue: Bool {
        defaultValue != nil
    }

    func generateMock(types: Types, accessLevel: String) -> String {
        isMutable ? generateMutableMock(types: types, accessLevel: accessLevel) : generateComputedMock(types: types, accessLevel: accessLevel)
    }

    func generateInitAssignment(types: Types) -> String {
        "\(name): \(typeName.generateStubbableName(type: type)) = \(typeName.generateDefaultValue(type: type, includeComplexType: true, types: types))"
    }
}

private extension Variable {
    func generateMutableMock(types: Types, accessLevel: String) -> String {
        let capitalizedName = name.capitalizingFirstLetter()
        let defaultValue = typeName.generateDefaultValue(type: type, includeComplexType: false, types: types)
        let nonOptionalSignature = defaultValue.isEmpty ? "!" : "! = \(defaultValue)"
        let typeName = typeName.isClosure ? "(\(typeName))" : typeName.name
        let listTypeName = self.typeName.isClosure ? "(\(typeName))" : self.typeName.name
        return """
            \(accessLevel) var invoked\(capitalizedName)Setter = false
            \(accessLevel) var invoked\(capitalizedName)SetterCount = 0
            \(accessLevel) var invoked\(capitalizedName): \(typeName)\(isOptional ? "" : "?")
            \(accessLevel) var invoked\(capitalizedName)List: [\(listTypeName)] = []
            \(accessLevel) var invoked\(capitalizedName)Getter = false
            \(accessLevel) var invoked\(capitalizedName)GetterCount = 0
            \(accessLevel) var stubbed\(capitalizedName): \(typeName)\(isOptional ? "" : nonOptionalSignature)

            \(accessLevel) var \(name): \(typeName) {
                get {
                    invoked\(capitalizedName)Getter = true
                    invoked\(capitalizedName)GetterCount += 1
                    return stubbed\(capitalizedName)
                }
                set {
                    invoked\(capitalizedName)Setter = true
                    invoked\(capitalizedName)SetterCount += 1
                    invoked\(capitalizedName) = newValue
                    invoked\(capitalizedName)List.append(newValue)
                }
            }
        """
    }

    func generateComputedMock(types: Types, accessLevel: String) -> String {
        let capitalizedName = name.capitalizingFirstLetter()
        let defaultValue = typeName.generateDefaultValue(type: type, includeComplexType: false, types: types)
        let nonOptionalSignature = defaultValue.isEmpty ? "!" : "! = \(defaultValue)"
        return """
            \(accessLevel) var invoked\(capitalizedName)Getter = false
            \(accessLevel) var invoked\(capitalizedName)GetterCount = 0
            \(accessLevel) var stubbed\(capitalizedName): \(typeName)\(isOptional ? "" : nonOptionalSignature)

            \(accessLevel) var \(name): \(typeName) {
                invoked\(capitalizedName)Getter = true
                invoked\(capitalizedName)GetterCount += 1
                return stubbed\(capitalizedName)
            }
        """
    }
}
