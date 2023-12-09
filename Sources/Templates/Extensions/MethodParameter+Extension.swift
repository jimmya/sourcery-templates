import SourceryRuntime

extension MethodParameter {
    func settableType(method: Method) -> String {
        var type = typeAttributes.isEscaping ? unwrappedTypeName : typeName.asSource
        if let generic = method.generics.first(where: { $0.name == type }) {
            return generic.constraints ?? "Any"
        }
        if isVariadic {
            type = "[\(type)]"
        }
        return type
    }

    func generateInitAssignment(types: Types, annotations: Annotations) -> String {
        "\(argumentLabel ?? name): \(typeName.generateStubbableName(type: type)) = \(typeName.generateDefaultValue(type: type, includeComplexType: true, types: types, annotations: annotations))"
    }
}
