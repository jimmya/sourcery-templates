public class MockNamingScheme {

    static let shared = MockNamingScheme()

    private var prefix: String = ""
    private var suffix: String = ""

    private init() { }

    func configure(
        prefix: String,
        suffix: String
    ) {
        self.prefix = prefix
        self.suffix = suffix

        if prefix.isEmpty && suffix.isEmpty {
            self.prefix = "Default"
            self.suffix = "Mock"
        }
    }

    func createMockNaming(typeName: String) -> String {
        "\(prefix)\(typeName)\(suffix)"
    }
}
