import SourceryRuntime

enum AutoMockable {
    static func generate(types: Types, annotations: Annotations) -> String {
        var lines: [String] = []
        lines.append(contentsOf: annotations.testableImports.map { "@testable import \($0)" })
        lines.append(contentsOf: annotations.imports.map { "import \($0)" })
        lines.append(.emptyLine)

        annotations.containerMapping?.forEach { module, containerName in
            lines.append("public final class \(containerName)Mocks {")
            lines.append(.emptyLine)

            let sortedProtocols = types.protocols
                .sorted(by: { $0.name < $1.name })
                .filter { $0.isAutoRegisterable && $0.isAutoMockable && $0.module == module }
            sortedProtocols.forEach { type in
                let mockName = annotations.mockName(typeName: type.name)
                let registrationName = type.name.withLowercaseFirst().withoutLastCamelCasedPart()
                lines.append("public lazy var \(registrationName) = \(mockName)()".indent())
            }

            lines.append(.emptyLine)
            lines.append("private let container: \(containerName) = .shared".indent())
            lines.append(.emptyLine)

            lines.append("public init() {".indent())
            sortedProtocols.forEach { type in
                let registrationName = type.name.withLowercaseFirst().withoutLastCamelCasedPart()
                lines.append("container.\(registrationName).context(.test, factory: { self.\(registrationName) })".indent(level: 2))
            }
            lines.append("}".indent())
            lines.append("}")
            lines.append(.emptyLine)
        }

        let sortedProtocols = types.protocols
            .sorted(by: { $0.name < $1.name })
            .filter(\.isAutoMockable)
            .filter { type in
                guard
                    let module = type.module,
                    let modules = annotations.modules
                else {
                    return true
                }
                return modules.contains(module)
            }
        let protocolLines = sortedProtocols.map { protocolType in
            protocolType.generateMock(types: types, annotations: annotations)
        }
        lines.append(contentsOf: protocolLines.joined(separator: [.emptyLine]))
        
        return lines.joined(separator: .newLine) + .newLine
    }
}
