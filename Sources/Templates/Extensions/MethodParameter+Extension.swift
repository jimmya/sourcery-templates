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
        if typeName.isOpaqueType && typeName.isOptional {
            type = typeName.withWrappedOptionalIfNeeded()
        }
        return type
    }

    func generateInitAssignment(types: Types) -> String {
        "\(argumentLabel ?? name): \(typeName.generateStubbableName(type: type)) = \(typeName.generateDefaultValue(type: type, includeComplexType: true, types: types))"
    }
}
