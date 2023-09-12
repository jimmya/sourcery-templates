import Foundation

extension String {
    static let newLine = "\n"
    static let emptyLine = ""

    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    func indent(level: Int = 1) -> String {
        Array(repeating: "    ", count: level).joined() + self
    }

    func matches(for regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch {
            return []
        }
    }
}
