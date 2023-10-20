import SourceryRuntime

extension TypeName {
    func generateDefaultValue(type: Type?, includeComplexType: Bool, types: Types) -> String {
        if type is Protocol, let firstImplementingType = try? types.implementing.types(forKey: name).first {
            return generateDefaultValue(type: firstImplementingType, includeComplexType: includeComplexType, types: types)
        }
        if isOptional && !isImplicitlyUnwrappedOptional {
            return "nil"
        }
        if isArray {
            return "[]"
        }
        if isDictionary {
            return "[:]"
        }
        if isOpaqueType {
            return "Default\(dropOpaqueKeywordIfNeeded())Mock()"
        }
        if isTuple, let tuple {
            let combinedElements = tuple.elements.map {
                $0.typeName.generateDefaultValue(type: $0.type, includeComplexType: includeComplexType, types: types)
            }.joined(separator: ", ")
            return "(\(combinedElements))"
        }
        if includeComplexType, let enumType = type as? Enum, let firstCase = enumType.cases.first {
            return generateEnumDefaultValue(firstCase: firstCase, includeComplexType: includeComplexType, types: types)
        }
        if isClosure, let closure {
            return "{ \(closure.returnTypeName.generateDefaultValue(type: closure.returnType, includeComplexType: includeComplexType, types: types)) } "
        }

        switch (unwrappedTypeName, includeComplexType) {
        case ("String", _), ("Character", _): return "\"\""
        case ("Int", _), ("Double", _), ("TimeInterval", _), ("CGFloat", _), ("Float", _): return "0"
        case ("Bool", _): return "false"
        case ("Void", _): return ""
        case ("Locale", true): return ".init(identifier: \"en_US\")"
        case ("URL", true): return "URL(fileURLWithPath: \"\")"
        case ("UIApplication", true): return ".shared" // UIApplication is special
        case (_, true):
            if type?.isAutoStubbable == true {
                // If we have multiple init methods, just use the first as a stub.
                if let type, type.initMethods.count > 1 {
                    return "\(generateStubbableName(type: type)).stub0()"
                }
                return "\(generateStubbableName(type: type)).stub()"
            } else if type?.isAutoMockable == true {
                return "Default\(unwrappedTypeName)Mock()"
            }

            return ".init()"
        default:
            return ""
        }
    }

    func generateStubbableName(type: Type?) -> String {
        let addition = (isOptional && !isImplicitlyUnwrappedOptional) ? "?" : ""
        if let dictionary {
            return dictionary.name + addition
        }
        if let array {
            var bracketCount = 1
            var elementTypeName = array.elementTypeName
            var elementType = array.elementType?.name ?? array.elementTypeName.name

            // If the type of Element is an array, loop the nested array recursively
            while let innerArrayType = elementTypeName.array {
                bracketCount += 1
                elementTypeName = innerArrayType.elementTypeName
                elementType = innerArrayType.elementType?.name ?? innerArrayType.elementTypeName.name
            }

            let openBrackets = String(repeating: "[", count: bracketCount)
            let closingBrackets = String(repeating: "]", count: bracketCount)

            let resultType = openBrackets + elementType + closingBrackets
            return resultType + addition
        }
        if isClosure, !isOptional {
            return "@escaping " + (type?.name ?? unwrappedTypeName) + addition
        }

        return (type?.name ?? unwrappedTypeName) + addition
    }

}

private extension TypeName {
    func generateEnumDefaultValue(firstCase: EnumCase, includeComplexType: Bool, types: Types) -> String {
        guard firstCase.hasAssociatedValue else {
            return ".\(firstCase.name)"
        }
        let associatedValue = firstCase.associatedValues.map { value in
            let defaultValue = value.defaultValue ?? value.typeName.generateDefaultValue(type: value.type, includeComplexType: includeComplexType, types: types)
            return [value.localName, defaultValue].compactMap { $0 }.joined(separator: ": ")
        }.joined(separator: ", ")
        return ".\(firstCase.name)(\(associatedValue))"
    }
}

// OpaqueType helpers
extension TypeName {

    var isOpaqueType: Bool {
        name
            .split(separator: " ")
            .map { String($0) }
            .contains { Constants.opaqueKeywords.contains($0) }
    }

    func wrapOptionalIfNeeded() -> String {
        isOpaqueType && isOptional ? "(\(unwrappedTypeName))?" : name
    }

    func dropOpaqueKeywordIfNeeded() -> String {
        guard isOpaqueType else { return name }

        return name
            .split(separator: " ")
            .dropFirst()
            .map { String($0) }
            .joined()
    }
}

private enum Constants {
    static let opaqueKeywords = ["any", "some"]
}
