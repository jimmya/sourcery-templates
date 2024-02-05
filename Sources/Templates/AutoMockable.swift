import SourceryRuntime

enum AutoMockable {
    static func generate(types: Types, annotations: Annotations) -> String {
        var lines: [String] = []
        lines.append(contentsOf: annotations.testableImports.map { "@testable import \($0)" })
        lines.append(contentsOf: annotations.imports.map { "import \($0)" })
        lines.append(.emptyLine)

        let sortedContainerMappings = annotations
            .containerMapping?
            .sorted(by: { $0.value < $1.value })

        sortedContainerMappings?.forEach { module, containerName in
            lines.append("public final class \(containerName)Mocks {")
            lines.append(.emptyLine)

            let sortedExtensionVariables = types.extensions
                .filter { $0.name == containerName }
                .flatMap { $0.computedVariables }
                .sorted(by: { $0.name < $1.name })

            let extensionRegistrations = generateRegistrations(
                variables: sortedExtensionVariables,
                annotations: annotations
            )

            let sortedProtocols = types.protocols
                .sorted(by: { $0.name < $1.name })
                .filter { $0.isAutoRegisterable && $0.isAutoMockable && $0.module == module }

            let protocolRegistrations = generateRegistrations(types: sortedProtocols, annotations: annotations)

            let registrations = extensionRegistrations + protocolRegistrations

            registrations.forEach { registration in
                let registrationName = registration.registrationName
                let mockName = registration.mockName
                lines.append("public lazy var \(registrationName) = \(mockName)()".indent())
            }

            lines.append(.emptyLine)
            lines.append("private let container: \(containerName) = .shared".indent())
            lines.append(.emptyLine)

            lines.append("public init(".indent())
            registrations.enumerated().forEach { index, registration in
                let suffix = index < registrations.count - 1 ? "," : ""
                let registrationName = registration.registrationName
                let mockName = registration.mockName
                lines.append("\(registrationName): \(mockName)? = nil\(suffix)".indent(level: 2))
            }
            lines.append(") {".indent())

            registrations.forEach { registration in
                let registrationName = registration.registrationName
                let mockName = registration.mockName
                lines.append("if let \(registrationName) { self.\(registrationName) = \(registrationName) }".indent(level: 2))
            }

            lines.append(.emptyLine)

            registrations.forEach { registration in
                let registrationName = registration.registrationName
                lines.append("container.\(registrationName).context(.test, factory: { self.\(registrationName) })".indent(level: 2))
            }
            lines.append("}".indent())
            lines.append("}")
            lines.append(.emptyLine)
        }

        let sortedProtocols = types.protocols
            .sorted(by: { $0.name < $1.name })
            .filter(\.isAutoMockable)
            .filter { type in
                guard
                    let module = type.module,
                    let modules = annotations.modules
                else {
                    return true
                }
                return modules.contains(module)
            }
        let protocolLines = sortedProtocols.map { protocolType in
            protocolType.generateMock(types: types, annotations: annotations)
        }
        lines.append(contentsOf: protocolLines.joined(separator: [.emptyLine]))
        
        return lines.joined(separator: .newLine) + .newLine
    }

    private static func generateRegistrations(
        types: [Type],
        annotations: Annotations
    ) -> [(registrationName: String, mockName: String)] {
        var result = [(String, String)]()
        types.forEach { type in
            let mockName = annotations.mockName(typeName: type.name)
            if let registrationValues = type.registrationValues {
                let nameAndValuePairs = registrationValues.components(separatedBy: ",")
                nameAndValuePairs.forEach { pair in
                    let nameAndValue = pair.components(separatedBy: "=")
                    guard nameAndValue.count == 2 else { return }
                    let registrationName = nameAndValue[0]
                    result.append((registrationName, mockName))
                }
            } else {
                let registrationName = type.name.withLowercaseFirst().withoutLastCamelCasedPart()
                result.append((registrationName, mockName))
            }
        }
        return result
    }

    private static func generateRegistrations(
        variables: [Variable],
        annotations: Annotations
    ) -> [(registrationName: String, mockName: String)] {
        var result = [(String, String)]()
        variables.forEach { variable in
            guard let genericType = variable.typeName.generic?.typeParameters.first else{
                return
            }
            guard !genericType.typeName.isClosure else {
                return
            }
            let type = genericType.typeName.array?.elementType ?? genericType.type
            let typeName = type?.name ?? genericType.typeName.name
            let mockName: String
            if type?.isAutoMockable == true {
                mockName = annotations.mockName(typeName: typeName)
            } else {
                mockName = typeName
            }
            let finalMockName = genericType.typeName.isArray ? "[\(mockName)]" : mockName
            result.append((variable.name, finalMockName))
        }
        return result
    }
}
