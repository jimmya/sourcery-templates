import SourceryRuntime

extension Annotations {
    var testableImports: [String] {
        self["testableImports"] as? [String] ?? []
    }

    var imports: [String] {
        self["imports"] as? [String] ?? []
    }
}

enum AutoMockable {
    static func generate(types: Types, annotations: Annotations) -> String {
        var lines: [String] = []
        lines.append(contentsOf: annotations.testableImports.map { "@testable import \($0)" })
        lines.append(contentsOf: annotations.imports.map { "import \($0)" })
        lines.append("")

        let sortedProtocols = types.protocols.sorted(by: { $0.name < $1.name }).filter(\.isAutoMockable)
        sortedProtocols.forEach { protocolType in
            lines.append(contentsOf: mock(type: protocolType))
        }
        return lines.joined(separator: .newLine)
    }

    static func mock(type: Protocol) -> [String] {
        let variables = type.allVariables.filter { $0.definedInType?.isExtension == false }
        let allMethods = type.allMethods.filter { $0.definedInType?.isExtension == false }.sorted()
        let variableLines = variables.flatMap { variable in
            [
                variable.generateMock(),
                "",
            ]
        }
        let methodLines: [String] = allMethods.flatMap { method in
            let methodName = generateMethodName(method: method, allMethods: allMethods).replacingOccurrences(of: "?", with: "")
            var lines = [
                mockStubParameters(methodName: methodName, method: method, type: type),
                mockMethodAttributes(method: method)
            ]
            if method.isInitializer {
                lines.append(contentsOf: [
                    "required \(method.name.replacingOccurrences(of: "?", with: "")) {".addingIndent(),
                    mockMethodReceivedParameters(methodName: methodName, method: method).addingIndent(count: 2),
                    "}".addingIndent(),
                ])
            } else {
                lines.append(contentsOf: [
                    mockMethodFunctionDeclaration(method: method, type: type).addingIndent(),
                    mockMethodReceivedParameters(methodName: methodName, method: method),
                    "}".addingIndent(),
                ])
            }
            return lines
        }
        var lines = [
            type.generateClassDeclaration(),
            "",
        ]
        lines.append(contentsOf: variableLines)
        lines.append(contentsOf: methodLines)
        lines.append("}")
        return lines
    }
}
