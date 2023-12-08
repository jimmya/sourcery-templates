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
    /// - If only the `mockPrefix` has a value, an empty suffix will be applied
    /// - If only the `mockSuffix` has a value, an empty prefix will be applied
    ///
    /// - Parameter typeName: Name of the class to generate the name for
    /// - Returns: The class name with appropriate prefix and suffix
    func mockName(typeName: String) -> String {
        var prefix = (mockPrefix ?? "").capitalizingFirstLetter()
        var suffix = (mockSuffix ?? "").capitalizingFirstLetter()

        if prefix.isEmpty && suffix.isEmpty {
            prefix = "Default"
            suffix = "Mock"
        }

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
