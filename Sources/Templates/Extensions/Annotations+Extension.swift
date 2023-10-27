import SourceryRuntime

extension Annotations {
    var testableImports: [String] {
        self["testableImports"] as? [String] ?? []
    }

    var imports: [String] {
        self["imports"] as? [String] ?? []
    }

    var modules: [String]? {
        self["modules"] as? [String]
    }

    var mockPrefix: String {
        self["mockPrefix"] as? String ?? ""
    }

    var mockSuffix: String {
        self["mockSuffix"] as? String ?? ""
    }
}
