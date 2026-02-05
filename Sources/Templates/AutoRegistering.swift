import SourceryRuntime

enum AutoRegistering {
    static func generate(types: Types, annotations: Annotations) -> String {
        var lines: [String] = []
        lines.append(contentsOf: annotations.imports.map { "import \($0)" })
        lines.append("")

        let containerName = annotations.containerName ?? "Container"
        lines.append("extension \(containerName): @retroactive AutoRegistering {")
        lines.append("public func autoRegister() {".indent())

        let sortedProtocols = types.protocols
            .filter(\.isAutoRegisterable)
            .sorted(by: { $0.name < $1.name })

        sortedProtocols.forEach { type in
            if let registrationValue = type.registrationValue {
                // If the registration value is specified we can register it directly
                let registrationName = type.name.withLowercaseFirst().withoutLastCamelCasedPart()
                lines.append("\(registrationName).register { \(registrationValue) }".indent(level: 2))
            } else if let registrationValues = type.registrationValues {
                // If multiple registration name-value pairs are specified we register them all
                let nameAndValuePairs = registrationValues.components(separatedBy: ",")
                nameAndValuePairs.forEach { pair in
                    let nameAndValue = pair.components(separatedBy: "=")
                    guard nameAndValue.count == 2 else { return }
                    let registrationName = nameAndValue[0]
                    let registrationValue = nameAndValue[1]
                    lines.append("\(registrationName).register { \(registrationValue) }".indent(level: 2))
                }
            } else if let autoRegisterTypes = type.autoRegisterTypes {
                autoRegisterTypes.forEach {
                    let registrationName = $0.name.withLowercaseFirst()
                    let registrationValue = $0.name
                    lines.append("\(registrationName).register { \(registrationValue)() }".indent(level: 2))
                }
            } else if let implementingType = getImplementingType(for: type) {
                // No registration values are specified, auto-generate registration
                lines.append(contentsOf: generateClassRegistration(for: type, registeringType: implementingType))
            }
        }

        lines.append("}".indent())
        lines.append("}")
        lines.append(.emptyLine)

        return lines.joined(separator: .newLine) + .newLine
    }
}

private extension AutoRegistering {

    static func registrationName(for type: Protocol) -> String {
        type.name.withLowercaseFirst().withoutLastCamelCasedPart()
    }

    static func getImplementingType(for type: Protocol) -> Type? {
        let registrationName = registrationName(for: type)
        return (types.all).first(where: {
            $0.implements.contains(where: { $0.value == type })
            && $0.name.withLowercaseFirst() == registrationName
        })
    }

    static func generateClassRegistration(for type: Protocol, registeringType: Type) -> [String] {
        let initMethods = registeringType.methods.filter(\.isInitializer)
        let registrationName = registrationName(for: type)
        var lines: [String] = []

        // We only support up to 1 init method, otherwise we can't determine for what to generate the registration parameters.
        if initMethods.count > 1 {
            fatalError("Max 1 init method is supported for AutoRegisterable")
        }

        let isShared = registeringType.staticVariables.contains { $0.name == "shared" }
        if !isShared, let initMethod = initMethods.first {
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
                return "\(label): self.\(registrationName)()"
            }
            guard canGenerateInit else {
                return lines
            }
            let joinedInitComponents = initComponents.joined(separator: ", ")
            lines.append("\(registrationName).register { \(registeringType.name)(\(joinedInitComponents)) }".indent(level: 2))
        } else {
            let instance = isShared ? ".shared" : "()"
            // If there is no init method in the protocol we can use the regular `Factory`
            lines.append("\(registrationName).register { \(registeringType.name)\(instance) }".indent(level: 2))
        }
        return lines
    }
}
