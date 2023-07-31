import SourceryRuntime

extension MethodParameter {
    var settableType: String {
        var type = typeAttributes.isEscaping ? unwrappedTypeName : typeName.asSource
        if isVariadic {
            type = "[\(type)]"
        }
        return type
    }
}
