import SourceryRuntime

extension ClosureType {
    
    /// The signature of the closure
    /// Returns `(<parameters>) <async> <throws> -> <returnType>`
    var typeSignature: String {
        let parameters = self.parameters.map { $0.typeName.withWrappedOptionalIfNeeded(isInout: $0.inout) }.joined(separator: ", ")

        return [
            "(\(parameters))",
            isAsync ? "async" : nil,
            throwsKeyword(isTyped: false),
            "->",
            returnTypeName.withWrappedOptionalIfNeeded()
        ]
            .compactMap { $0 }
            .joined(separator: " ")
    }
    
    /// The `throws` keyword of the closure, e.g. `throws` or `throws(MyError)`.
    ///
    /// - Parameter isTyped: Whether to keep the thrown error type. The method's parameter has to keep it to conform
    ///   to the protocol. A typed-throws function type that is *stored* (e.g. the captured parameters) needs iOS 18,
    ///   so the stored `typeSignature` always uses a plain `throws`.
    func throwsKeyword(isTyped: Bool) -> String? {
        guard self.throws else { return nil }
        guard isTyped, let throwsTypeName else { return "throws" }
        return "throws(\(throwsTypeName.name))"
    }

    /// Create closure signature as parameter
    ///
    /// If the parameter is optional, the closure will be wrapped
    ///
    /// - Parameter parameter: parameter to create the signature for
    /// - Returns: `<parameterName>: <@escaping> <@Sendable> <@MainActor> (<parameters>) <async> <throws> -> <returnType>`
    func signature(fromMethodParameter parameter: MethodParameter) -> String {
        let parameters = parameters.map { $0.typeName.withWrappedOptionalIfNeeded(isInout: $0.inout) }.joined(separator: ", ")

        let returnType = returnTypeName.withWrappedOptionalIfNeeded()

        let escapingString = parameter.typeAttributes.isEscaping ? "@escaping" : nil
        let sendableString = parameter.typeAttributes.isSendable ? "@Sendable" : nil
        let mainActorString = parameter.typeAttributes.isMainActor ? "@MainActor" : nil

        let isOptional = parameter.typeName.isOptional

        return [
            "\(parameter.combinedName):",
            escapingString,
            sendableString,
            mainActorString,
            "\(isOptional ? "(" : "")(\(parameters))",
            isAsync ? "async" : nil,
            throwsKeyword(isTyped: true),
            "->",
            "\(returnType)\(isOptional ? ")?" : "")"
        ]
            .compactMap { $0 }
            .joined(separator: " ")

    }
}
