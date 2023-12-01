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

    func withLowercaseFirst() -> String {
        guard let index = self.firstIndex(where: { $0.isLowercase }) else {
            return self
        }
        var uppercasePart = String(self[..<index])
        let lowercasePart = String(self[index...])
        if uppercasePart.count == 1 {
            return uppercasePart.lowercased() + lowercasePart
        }
        let firstUpperCase = uppercasePart.removeLast()
        return uppercasePart.lowercased() + firstUpperCase.uppercased() + lowercasePart
    }

    func withoutLastCamelCasedPart() -> String {
        guard let index = self.lastIndex(where: { $0.isUppercase }) else {
            return self
        }
        return String(self[..<index])
    }
}
