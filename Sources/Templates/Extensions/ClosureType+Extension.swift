import SourceryRuntime

extension ClosureType {
    
    /// The signature of the closure, manually dissected
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

    func signature(fromMethodParameter parameter: MethodParameter) -> String {
        let parameters = parameters.map { $0.typeName.withWrappedOptionalIfNeeded() }.joined(separator: ", ")

        let returnType = returnTypeName.withWrappedOptionalIfNeeded()

        let escapingString = parameter.typeAttributes.isEscaping ? "@escaping" : nil
        let isOptional = parameter.typeName.isOptional

        return [
            "\(parameter.name):",
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
