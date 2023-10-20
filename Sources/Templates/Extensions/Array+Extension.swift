import Foundation

public extension Array where Element: Hashable {

    var distinct: Array {
        var buffer = Array()
        var added = Set<Element>()
        
        for element in self {
            if !added.contains(element) {
                buffer.append(element)
                added.insert(element)
            }
        }

        return buffer
    }
}
