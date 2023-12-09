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

    var mockPrefix: String? {
        self["mockPrefix"] as? String
    }

    var mockSuffix: String? {
        self["mockSuffix"] as? String
    }

    /// Will add a prefix and suffix to the input `String`
    ///
    /// The default prefix and suffix are `Default` and `Mock` respectively.
    ///
    /// - Parameter typeName: Name of the class to generate the name for
    /// - Returns: The class name with appropriate prefix and suffix
    func mockName(typeName: String) -> String {
        let prefix = (mockPrefix ?? "Default").capitalizingFirstLetter()
        let suffix = (mockSuffix ?? "Mock").capitalizingFirstLetter()

        return prefix + typeName + suffix
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
