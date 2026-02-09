import SourceryRuntime

extension AttributeList {
    var isEscaping: Bool {
        contains(where: { $0.key == "escaping" })
    }

    var isSendable: Bool {
        contains(where: { $0.key == "Sendable" })
    }

    var isMainActor: Bool {
        contains(where: { $0.key == "MainActor" })
    }
}
