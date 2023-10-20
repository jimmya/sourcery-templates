import SourceryRuntime

extension MethodParameter {
    var settableType: String {
        var type = typeAttributes.isEscaping ? unwrappedTypeName : typeName.asSource
        if isVariadic {
            type = "[\(type)]"
        }
        if typeName.isOpaqueType && typeName.isOptional {
            type = typeName.wrapOptionalIfNeeded()
        }
        return type
    }
}
