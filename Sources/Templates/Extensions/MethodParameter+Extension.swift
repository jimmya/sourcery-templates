import SourceryRuntime

extension MethodParameter {
    
    /// The combined external and internal name of the parameter
    var combinedName: String {
        // Sourcery has an issue/feature where the `argumentLabel` and `name` can be the same, so filter if they are the same
        [
            argumentLabel ?? "_",
            name
        ]
            .compactMap { $0 }
            .unique()
            .joined(separator: " ")
    }

    func settableType(method: Method) -> String {
        var type = typeAttributes.isEscaping ? unwrappedTypeName : typeName.asSource
        if let generic = method.generics.first(where: { $0.name == type || $0.name == unwrappedTypeName }) {
            let optionalSuffix = isOptional ? "?" : "!"
            return generic.constraints.map { $0 + optionalSuffix } ?? "Any"
        }
        if let generic = method.generics.first(where: { $0.constraints == type }) {
            return generic.constraints ?? "Any"
        }
        if typeName.isGeneric && !typeName.isArray && !typeName.isDictionary {
            return "Any"
        }
        if isVariadic {
            type = "[\(type)]"
        }
        if typeName.isOpaqueType {
            type = typeName.withWrappedOptionalIfNeeded()
        }
        if let closure = typeName.closure {
            type = closure.typeSignature
        }

        return type
    }

    func generateInitAssignment(types: Types, annotations: Annotations) -> String {
        "\(argumentLabel ?? name): \(typeName.generateStubbableName(type: type)) = \(typeName.generateDefaultValue(type: type, includeComplexType: true, types: types, annotations: annotations))"
    }
}
