import SourceryRuntime

enum FactoryTest {
    static func generate(types: Types, annotations: Annotations) -> String {
        var lines: [String] = []
        lines.append(contentsOf: annotations.testableImports.map { "@testable import \($0)" })
        lines.append(contentsOf: annotations.imports.map { "import \($0)" })
        lines.append("")
        lines.append("final class FactoryTests: XCTestCase {")
        lines.append("func testFactoryRegistrations() {".indent())

        types.extensions.filter { $0.name == "Container" }.forEach { container in
            var containerName = "Container"
            if let module = container.module, let customContainerName = annotations.containerMapping?[module] {
                containerName = customContainerName
            }
            container.allVariables.forEach { variable in
                lines.append("_ = \(containerName).shared.\(variable.name).resolve()".indent(level: 2))
            }
        }

        let sortedProtocols = types.protocols
            .filter(\.isAutoRegisterable)
        sortedProtocols.forEach { type in
            let initMethods = type.methods.filter(\.isInitializer)

            if initMethods.count > 1 {
                fatalError("Max 1 init method is supported for AutoRegisterable")
            }

            var containerName = "Container"
            if let module = type.module, let customContainerName = annotations.containerMapping?[module] {
                containerName = customContainerName
            }
            let registrationName = type.name.withLowercaseFirst().withoutLastCamelCasedPart()
            if let initMethod = initMethods.first {
                let typeNames = initMethod.parameters.map { $0.typeName.generateDefaultValue(type: $0.type, includeComplexType: true, types: types) }
                let joinedTypes = typeNames.joined(separator: ", ")
                let types = typeNames.count == 1 ? joinedTypes : "(\(joinedTypes))"
                lines.append("_ = \(containerName).shared.\(registrationName).resolve(\(types))".indent(level: 2))
            } else {
                lines.append("_ = \(containerName).shared.\(registrationName).resolve()".indent(level: 2))
            }
        }

        lines.append("}".indent())
        lines.append("}")

        return lines.joined(separator: .newLine) + .newLine
    }
}
