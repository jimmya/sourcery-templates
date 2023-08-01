import SourceryRuntime

enum AutoMockable {
    static func generate(types: Types, annotations: Annotations) -> String {
        var lines: [String] = []
        lines.append(contentsOf: annotations.testableImports.map { "@testable import \($0)" })
        lines.append(contentsOf: annotations.imports.map { "import \($0)" })
        lines.append(.emptyLine)

        let sortedProtocols = types.protocols.sorted(by: { $0.name < $1.name }).filter(\.isAutoMockable)
        let protocolLines = sortedProtocols.map { protocolType in
            protocolType.generateMock(types: types)
        }
        lines.append(contentsOf: protocolLines.joined(separator: [.emptyLine]))
        
        return lines.joined(separator: .newLine)
    }
}
