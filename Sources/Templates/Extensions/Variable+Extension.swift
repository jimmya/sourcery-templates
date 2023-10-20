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
            \(accessLevel) var invoked\(capitalizedName)Setter = false
            \(accessLevel) var invoked\(capitalizedName)SetterCount = 0
            \(accessLevel) var invoked\(capitalizedName): \(invokedObjectType)
            \(accessLevel) var invoked\(capitalizedName)List: [\(listTypeName)] = []
            \(accessLevel) var invoked\(capitalizedName)Getter = false
            \(accessLevel) var invoked\(capitalizedName)GetterCount = 0
            \(accessLevel) var stubbed\(capitalizedName): \(stubbedObjectType)

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

        var stubbedObjectType = "\(typeName.name)\(isOptional ? "" : nonOptionalSignature)"
        let returnTypeName = typeName.wrapOptionalIfNeeded()

        if typeName.isOpaqueType {
            stubbedObjectType = "(\(typeName.unwrappedTypeName))\(isOptional ? "" : nonOptionalSignature)"
        }

        return """
            \(accessLevel) var invoked\(capitalizedName)Getter = false
            \(accessLevel) var invoked\(capitalizedName)GetterCount = 0
            \(accessLevel) var stubbed\(capitalizedName): \(stubbedObjectType)

            \(accessLevel) var \(name): \(typeName) {
                invoked\(capitalizedName)Getter = true
                invoked\(capitalizedName)GetterCount += 1
                return stubbed\(capitalizedName)
            }
        """
    }
}
