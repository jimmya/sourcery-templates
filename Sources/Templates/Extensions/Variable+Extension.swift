import SourceryRuntime

extension Variable {
    var hasDefaultValue: Bool {
        defaultValue != nil
    }

    func generateMock(types: Types, accessLevel: String, annotations: Annotations) -> String {
        isMutable ? generateMutableMock(types: types, accessLevel: accessLevel, annotations: annotations) : generateComputedMock(types: types, accessLevel: accessLevel, annotations: annotations)
    }

    func generateInitAssignment(types: Types, annotations: Annotations) -> String {
        "\(name): \(typeName.generateStubbableName(type: type)) = \(typeName.generateDefaultValue(type: type, includeComplexType: true, types: types, annotations: annotations))"
    }
}

private extension Variable {
    func generateMutableMock(types: Types, accessLevel: String, annotations: Annotations) -> String {
        let capitalizedName = name.capitalizingFirstLetter()
        let defaultValue = typeName.generateDefaultValue(type: type, includeComplexType: false, types: types, annotations: annotations)
        let nonOptionalSignature = defaultValue.isEmpty ? "!" : "! = \(defaultValue)"

        var invokedObjectType = "\(typeName.name)\(isOptional ? "" : "?")"
        var listTypeName = typeName.name
        var stubbedObjectType = "\(typeName.name)\(isOptional ? "" : nonOptionalSignature)"
        var returnTypeName = typeName.name

        if typeName.isOpaqueType {
            let optionalOpaqueTypeName = typeName.withWrappedOptionalIfNeeded()
            invokedObjectType = "(\(typeName.unwrappedTypeName))?"
            listTypeName = optionalOpaqueTypeName
            stubbedObjectType = "(\(typeName.unwrappedTypeName))\(isOptional ? "?" : nonOptionalSignature)"
            returnTypeName = "\(optionalOpaqueTypeName)"
        }

        if let closure = typeName.closure {
            let closureSignature = closure.typeSignature

            invokedObjectType = "(\(closureSignature))?"
            listTypeName = typeName.isOptional ? "(\(closureSignature))?" : closureSignature
            stubbedObjectType = typeName.isOptional ? "(\(closureSignature))?" : "(\(closureSignature))!"
            returnTypeName = typeName.isOptional ? "(\(closureSignature))?" : closureSignature
        }

        return """
            \(accessLevel) var invoked\(capitalizedName)Setter = false
            \(accessLevel) var invoked\(capitalizedName)SetterCount = 0
            \(accessLevel) var invoked\(capitalizedName): \(invokedObjectType)
            \(accessLevel) var invoked\(capitalizedName)List: [\(listTypeName)] = []
            \(accessLevel) var invoked\(capitalizedName)Getter = false
            \(accessLevel) var invoked\(capitalizedName)GetterCount = 0
            \(accessLevel) var stubbed\(capitalizedName): \(stubbedObjectType)

            \(accessLevel) var \(name): \(returnTypeName) {
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

    func generateComputedMock(types: Types, accessLevel: String, annotations: Annotations) -> String {
        let capitalizedName = name.capitalizingFirstLetter()
        let defaultValue = typeName.generateDefaultValue(type: type, includeComplexType: false, types: types, annotations: annotations)
        let nonOptionalSignature = defaultValue.isEmpty ? "!" : "! = \(defaultValue)"

        var stubbedObjectType = "\(typeName.name)\(isOptional ? "" : nonOptionalSignature)"
        var returnTypeName = typeName.withWrappedOptionalIfNeeded()

        if typeName.isOpaqueType {
            stubbedObjectType = "(\(typeName.unwrappedTypeName))\(isOptional ? "?" : nonOptionalSignature)"
        }

        if let closure = typeName.closure {
            let closureSignature = closure.typeSignature

            stubbedObjectType = typeName.isOptional ? "(\(closureSignature))?" : "(\(closureSignature))!"
            returnTypeName = typeName.isOptional ? "(\(closureSignature))?" : closureSignature
        }

        return """
            \(accessLevel) var invoked\(capitalizedName)Getter = false
            \(accessLevel) var invoked\(capitalizedName)GetterCount = 0
            \(accessLevel) var stubbed\(capitalizedName): \(stubbedObjectType)

            \(accessLevel) var \(name): \(returnTypeName) {
                invoked\(capitalizedName)Getter = true
                invoked\(capitalizedName)GetterCount += 1
                return stubbed\(capitalizedName)
            }
        """
    }
}
