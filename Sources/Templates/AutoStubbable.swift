import SourceryRuntime

enum AutoStubbable {
    static func generate(types: Types, annotations: Annotations) -> String {
        var lines: [String] = []
        lines.append(contentsOf: annotations.testableImports.map { "@testable import \($0)" })
        lines.append(contentsOf: annotations.imports.map { "import \($0)" })
        lines.append("")

        let sortedTypes = (types.structs + types.classes).sorted(by: { $0.name < $1.name }).filter(\.isAutoStubbable)
        let types = sortedTypes.map { type in
            type.generateStub(types: types)
        }.joined(separator: [.emptyLine])
        lines.append(contentsOf: types)
        
        return lines.joined(separator: .newLine)
    }
}
