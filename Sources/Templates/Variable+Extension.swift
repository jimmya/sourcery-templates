import SourceryRuntime

extension Variable {

    func generateMock() -> String {
        isMutable ? mockMutable : mockComputed
    }
}

private extension Variable {
    var mockMutable: String {
        let capitalizedName = name.capitalizingFirstLetter()
        let defaultValue = generateDefaultValue(type: type, typeName: typeName, includeComplexType: false)
        let nonOptionalSignature = defaultValue.isEmpty ? "!" : "! = \(defaultValue)"
        let typeName = typeName.isClosure ? "(\(typeName))" : typeName.name
        let listTypeName = self.typeName.isClosure ? "(\(typeName))" : self.typeName.name
        return """
            var invoked\(capitalizedName)Setter = false
            var invoked\(capitalizedName)SetterCount = 0
            var invoked\(capitalizedName): \(typeName)\(isOptional ? "" : "?")
            var invoked\(capitalizedName)List: [\(listTypeName)] = []
            var invoked\(capitalizedName)Getter = false
            var invoked\(capitalizedName)GetterCount = 0
            var stubbed\(capitalizedName): \(typeName)\(isOptional ? "" : nonOptionalSignature)

            var \(name): \(typeName) {
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

    var mockComputed: String {
        let capitalizedName = name.capitalizingFirstLetter()
        let defaultValue = generateDefaultValue(type: type, typeName: typeName, includeComplexType: false)
        let nonOptionalSignature = defaultValue.isEmpty ? "!" : "! = \(defaultValue)"
        return """
            var invoked\(capitalizedName)Getter = false
            var invoked\(capitalizedName)GetterCount = 0
            var stubbed\(capitalizedName): \(typeName)\(isOptional ? "" : nonOptionalSignature)

            var \(name): \(typeName) {
                invoked\(capitalizedName)Getter = true
                invoked\(capitalizedName)GetterCount += 1
                return stubbed\(capitalizedName)
            }
        """
    }
}
