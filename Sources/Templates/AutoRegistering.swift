import SourceryRuntime

enum AutoRegistering {
    static func generate(types: Types, annotations: Annotations) -> String {
        var lines: [String] = []
        lines.append(contentsOf: annotations.imports.map { "import \($0)" })
        lines.append("")

        let containerName = annotations.containerName ?? "Container"
        lines.append("extension \(containerName): AutoRegistering {")
        lines.append("public func autoRegister() {".indent())

        let sortedProtocols = types.protocols
            .sorted(by: { $0.name < $1.name })
            .filter(\.isAutoRegisterable)

        sortedProtocols.forEach { type in
            guard let implementingClass = types.classes.first(where: { $0.implements.contains(where: { $0.value == type }) }) else {
                return
            }
            let initMethods = implementingClass.methods.filter(\.isInitializer)
            let registrationName = type.name.withLowercaseFirst().withoutLastCamelCasedPart()

            // We only support up to 1 init method, otherwise we can't determine for what to generate the registration parameters.
            if initMethods.count > 1 {
                fatalError("Max 1 init method is supported for AutoRegisterable")
            }

            if let initMethod = initMethods.first {
                var canGenerateInit = true
                var initComponents: [String] = initMethod.parameters.compactMap { parameter in
                    guard parameter.defaultValue == nil else {
                        return nil
                    }
                    guard let type = parameter.type else {
                        canGenerateInit = false
                        return nil
                    }
                    let label = parameter.argumentLabel ?? parameter.name
                    return "\(label): self.\(type.name.withLowercaseFirst().withoutLastCamelCasedPart())()"
                }
                guard canGenerateInit else {
                    return
                }
                let joinedInitComponents = initComponents.joined(separator: ", ")
                lines.append("\(registrationName).register { \(implementingClass.name)(\(joinedInitComponents)) }".indent(level: 2))
            } else {
                let isShared = implementingClass.staticVariables.contains { $0.name == "shared" }
                let instance = isShared ? ".shared" : "()"
                // If there is no init method in the protocol we can use the regular `Factory`
                lines.append("\(registrationName).register { \(implementingClass.name)\(instance) }".indent(level: 2))
            }
        }
        lines.append("}".indent())
        lines.append("}")
        lines.append(.emptyLine)

        return lines.joined(separator: .newLine) + .newLine
    }
}
