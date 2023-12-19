import SourceryRuntime

extension MethodParameter {

    var externalInternalName: String {
        [
            argumentLabel,
            name
        ]
            .compactMap { $0 }
            .unique()
            .joined(separator: " ")
    }

    func settableType(method: Method) -> String {
        var type = typeAttributes.isEscaping ? unwrappedTypeName : typeName.asSource
        if let generic = method.generics.first(where: { $0.name == type }) {
            return generic.constraints ?? "Any"
        }
        if isVariadic {
            type = "[\(type)]"
        }
        if typeName.isOpaqueType {
            type = typeName.withWrappedOptionalIfNeeded()
        }
        return type
    }

    func generateInitAssignment(types: Types, annotations: Annotations) -> String {
        "\(argumentLabel ?? name): \(typeName.generateStubbableName(type: type)) = \(typeName.generateDefaultValue(type: type, includeComplexType: true, types: types, annotations: annotations))"
    }
}
