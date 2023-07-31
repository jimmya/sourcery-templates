import SourceryRuntime

extension Protocol {
    func generateMock() -> [String] {
        let variables = allVariables.filter { $0.definedInType?.isExtension == false }
        let variableLines = variables.flatMap { variable in
            [
                variable.generateMock(),
                .emptyLine,
            ]
        }

        let allMethods = allMethods.filter { $0.definedInType?.isExtension == false }.sorted()
        var takenMethodNames: Set<String> = []
        let methodLines: [[String]] = allMethods.map { method in
            method.generateMock(takenNames: &takenMethodNames, allMethods: allMethods, in: self)
        }
        
        return [
            generateClassDeclaration(),
            .emptyLine,
        ]
        + variableLines
        + methodLines.joined(separator: [.emptyLine])
        + ["}"]
    }
}

private extension Protocol {
    /// Returns `class DefaultProtocolNameMock: InheritedTypes {`
    func generateClassDeclaration() -> String {
        "\(mockType) Default\(name)Mock: \(mockInheritedTypes) {"
    }

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
