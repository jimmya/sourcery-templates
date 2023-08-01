import SourceryRuntime

extension MethodParameter {
    var settableType: String {
        var type = typeAttributes.isEscaping ? unwrappedTypeName : typeName.asSource
        if isVariadic {
            type = "[\(type)]"
        }
        return type
    }

    func generateInitAssignment(types: Types) -> String {
        "\(argumentLabel ?? name): \(typeName.generateStubbableName(type: type)) = \(typeName.generateDefaultValue(type: type, includeComplexType: true, types: types))"
    }
}
