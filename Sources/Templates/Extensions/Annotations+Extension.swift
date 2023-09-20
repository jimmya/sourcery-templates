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
}
