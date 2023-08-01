import SourceryRuntime

extension Protocol {
    func generateMock(types: Types) -> [String] {
        let variables = allVariables.filter { $0.definedInType?.isExtension == false }
        let variableLines = variables.map { variable in
            [
                variable.generateMock(types: types),
            ]
        }

        let allMethods = allMethods.filter { $0.definedInType?.isExtension == false }.sorted()
        var takenMethodNames: Set<String> = []
        let methodLines: [[String]] = allMethods.map { method in
            method.generateMock(takenNames: &takenMethodNames, allMethods: allMethods, in: self, types: types)
        }

        let hasVariablesAndMethods = !variableLines.isEmpty && !methodLines.isEmpty
        return [
            generateClassDeclaration(),
            .emptyLine
        ]
        + variableLines.joined(separator: [.emptyLine])
        + (hasVariablesAndMethods ? [.emptyLine] : [])
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
        // If we have a method that returns `Self` we must declare the class final
        let shouldBeFinal = methods.contains(where: { $0.returnTypeName.name == "Self"} )
        return shouldBeFinal ? "final class" : "class"
    }
}

private extension Array where Element == Method {

    func sorted() -> Self {
        sorted { one, two in
            if one.callName == two.callName {
                return one.parameters.count < two.parameters.count
            } else {
                return one.callName < two.callName
            }
        }
    }
}
