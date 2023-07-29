import SourceryRuntime

extension Protocol {
    /// Returns `class DefaultProtocolNameMock: InheritedTypes {`
    func generateClassDeclaration() -> String {
        "\(mockType) Default\(name)Mock: \(mockInheritedTypes) {"
    }
}

private extension Protocol {
    var mockInheritedTypes: String {
        let inherited = genericRequirements.map { "\($0.rightType.typeName.name), " }.joined()
        return "\(inherited)\(name)"
    }

    var mockType: String {
        if based.contains(where: { $0.key == "AnyActor"}) {
            return "actor"
        }
        return isFinal ? "final class" : "class"
    }
}
