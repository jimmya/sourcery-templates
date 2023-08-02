extension String {
    static let newLine = "\n"
    static let emptyLine = ""

    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    func indent(level: Int = 1) -> String {
        Array(repeating: "    ", count: level).joined() + self
    }
}
