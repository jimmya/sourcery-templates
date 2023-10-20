import SourceryRuntime

extension Variable {
    func generateMock() -> String {
        isMutable ? mockMutable : mockComputed
    }
}

private extension Variable {
    var mockMutable: String {
        let capitalizedName = name.capitalizingFirstLetter()
        let defaultValue = typeName.generateDefaultValue(type: type, includeComplexType: false)
        let nonOptionalSignature = defaultValue.isEmpty ? "!" : "! = \(defaultValue)"

        var mutableTypeName = typeName.name

        if typeName.isClosure {
            mutableTypeName = "(\(typeName.unwrappedTypeName))"
        }

        var listTypeName = mutableTypeName
        var invokedObjectType = "\(mutableTypeName)\(isOptional ? "" : "?")"
        var stubbedObjectType = "\(mutableTypeName)\(isOptional ? "" : nonOptionalSignature)"
        var returnTypeName = mutableTypeName

        if typeName.isOpaqueType {
            let optionalOpaqueTypeName = typeName.wrapOptionalIfNeeded()
            invokedObjectType = optionalOpaqueTypeName
            listTypeName = optionalOpaqueTypeName
            stubbedObjectType = "(\(typeName.unwrappedTypeName))\(isOptional ? "" : nonOptionalSignature)"
            returnTypeName = optionalOpaqueTypeName
        }

        return """
            var invoked\(capitalizedName)Setter = false
            var invoked\(capitalizedName)SetterCount = 0
            var invoked\(capitalizedName): \(invokedObjectType)
            var invoked\(capitalizedName)List: [\(listTypeName)] = []
            var invoked\(capitalizedName)Getter = false
            var invoked\(capitalizedName)GetterCount = 0
            var stubbed\(capitalizedName): \(stubbedObjectType)

            var \(name): \(returnTypeName) {
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
        let defaultValue = typeName.generateDefaultValue(type: type, includeComplexType: false)
        let nonOptionalSignature = defaultValue.isEmpty ? "!" : "! = \(defaultValue)"

        var stubbedObjectType = "\(typeName.name)\(isOptional ? "" : nonOptionalSignature)"
        let returnTypeName = typeName.wrapOptionalIfNeeded()

        if typeName.isOpaqueType {
            stubbedObjectType = "(\(typeName.unwrappedTypeName))\(isOptional ? "" : nonOptionalSignature)"
        }

        return """
            var invoked\(capitalizedName)Getter = false
            var invoked\(capitalizedName)GetterCount = 0
            var stubbed\(capitalizedName): \(stubbedObjectType)

            var \(name): \(returnTypeName) {
                invoked\(capitalizedName)Getter = true
                invoked\(capitalizedName)GetterCount += 1
                return stubbed\(capitalizedName)
            }
        """
    }
}
