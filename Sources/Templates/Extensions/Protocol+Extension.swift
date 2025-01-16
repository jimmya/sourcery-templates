import SourceryRuntime

extension Protocol {
    func generateMock(types: Types, annotations: Annotations) -> [String] {
        let variables = allVariables.filter { $0.definedInType?.isExtension == false }
        let variableLines = variables.map { variable in
            [
                variable.generateMock(types: types, accessLevel: accessLevel, annotations: annotations),
            ]
        }

        let allMethods = allMethods.filter { $0.definedInType?.isExtension == false }.sorted()
        var takenMethodNames: Set<String> = []
        var methodLines: [[String]] = []
        if genericRequirements.isEmpty {
            methodLines.append(["\(accessLevel) init() { }".indent()])
        }
        methodLines.append(contentsOf: allMethods.map { method in
            method.generateMock(takenNames: &takenMethodNames, allMethods: allMethods, in: self, types: types, accessLevel: accessLevel, annotations: annotations)
        })

        let hasVariablesAndMethods = !variableLines.isEmpty && !methodLines.isEmpty
        return [
            generateClassDeclaration(annotations: annotations),
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
    func generateClassDeclaration(annotations: Annotations) -> String {
        var sendableNaming = ""
        if self.inheritedTypes.contains(where: { $0 == "Sendable" }) {
            sendableNaming = ", @unchecked Sendable"
        }

        let mockNaming = annotations.mockName(typeName: name)
        return "\(accessLevel) \(mockType) \(mockNaming): \(mockInheritedTypes)\(sendableNaming) {"
    }

    var mockInheritedTypes: String {
        let inherited = genericRequirements.map { "\($0.rightType.typeName.name), " }.joined()
        return "\(inherited)\(name)"
    }

    var mockType: String {
        if based.contains(where: { $0.key == "AnyActor" || $0.key == "Actor" }) {
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
                if one.parameters.count == two.parameters.count {
                    return one.generics.count < two.generics.count
                }
                return one.parameters.count < two.parameters.count
            } else {
                return one.callName < two.callName
            }
        }
    }
}
