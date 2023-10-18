import SourceryRuntime

extension AttributeList {
    var isEscaping: Bool {
        contains(where: { $0.key == "escaping" })
    }
}
