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

    var containerName: String? {
        self["containerName"] as? String
    }

    var propertyWrapperName: String? {
        self["propertyWrapperName"] as? String
    }

    var containerMapping: [String: String]? {
        self["containerMapping"] as? [String: String]
    }
}
