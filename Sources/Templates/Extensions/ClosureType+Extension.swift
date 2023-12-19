import SourceryRuntime

extension ClosureType {
    
    /// The signature of the closure
    /// Returns `(<parameters>) <async> <throws> -> <returnType>`
    var typeSignature: String {
        let parameters = self.parameters.map { $0.typeName.withWrappedOptionalIfNeeded() }.joined(separator: ", ")

        return [
            "(\(parameters))",
            isAsync ? "async" : nil,
            self.throws ? "throws" : nil,
            "->",
            returnTypeName.withWrappedOptionalIfNeeded()
        ]
            .compactMap { $0 }
            .joined(separator: " ")
    }
    
    /// Create closure signature as parameter
    ///
    /// If the parameter is optional, the closure will be wrapped
    ///
    /// - Parameter parameter: parameter to create the signature for
    /// - Returns: `<parameterName>: <@escaping> (<parameters>) <async> <throws> -> <returnType>`
    func signature(fromMethodParameter parameter: MethodParameter) -> String {
        let parameters = parameters.map { $0.typeName.withWrappedOptionalIfNeeded() }.joined(separator: ", ")

        let returnType = returnTypeName.withWrappedOptionalIfNeeded()

        let escapingString = parameter.typeAttributes.isEscaping ? "@escaping" : nil
        let isOptional = parameter.typeName.isOptional

        return [
            "\(parameter.externalInternalName):",
            escapingString,
            "\(isOptional ? "(" : "")(\(parameters))",
            isAsync ? "async" : nil,
            self.throws ? "throws" : nil,
            "->",
            "\(returnType)\(isOptional ? ")?" : "")"
        ]
            .compactMap { $0 }
            .joined(separator: " ")

    }
}
