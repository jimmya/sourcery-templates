import SourceryRuntime

enum AutoRegisterable {
    static func generate(types: Types, annotations: Annotations) -> String {
        var lines: [String] = []
        lines.append(contentsOf: annotations.imports.map { "import \($0)" })
        lines.append("")

        let customContainerName = annotations.containerName
        if let customContainerName {
            lines.append("public final class \(customContainerName): SharedContainer {")
            lines.append("public static var shared = \(customContainerName)()".indent())
            lines.append("public var manager = ContainerManager()".indent())
            lines.append("}")
            lines.append(.emptyLine)
        }
        let containerName = customContainerName ?? "Container"

        lines.append("extension \(containerName) {")

        let sortedProtocols = types.protocols
            .sorted(by: { $0.name < $1.name })
            .filter(\.isAutoRegisterable)

        sortedProtocols.forEach { type in
            if let registrationValues = type.registrationValues {
                // If the registration values are specified we can use the regular `Factory`
            	let nameAndValuePairs = registrationValues.components(separatedBy: ",")
                nameAndValuePairs.forEach { pair in
                    let nameAndValue = pair.components(separatedBy: "=")
                    guard nameAndValue.count == 2 else { return }
                    let registrationName = nameAndValue[0]
                    lines.append("public var \(registrationName): Factory<\(type.name)> {".indent(level: 1))
                    lines.append("self { fatalError(\"\(registrationName) not registered\") }".indent(level: 2))
                    lines.append("}".indent(level: 1))
                }
            } else {
                let initMethods = type.methods.filter(\.isInitializer)
                let registrationName = type.name.withLowercaseFirst().withoutLastCamelCasedPart()
    
                // We only support up to 1 init method, otherwise we can't determine for what to generate the registration parameters.
                if initMethods.count > 1 {
                    fatalError("Max 1 init method is supported for AutoRegisterable")
                }
    
                if let initMethod = initMethods.first {
                    let parameterType: String
                    // Factory works with tuples for more than 1 parameter.
                    if initMethod.parameters.count == 1 {
                        // If we have a single parameter we directly set it.
                        parameterType = initMethod.parameters[0].typeName.name
                    } else {
                        // If there are more parameters we create a tuple with the types and argument labels
                        // E.g. `(foo: String, bar: Int)`
                        let joinedParameters = initMethod.parameters.map { "\($0.argumentLabel ?? $0.name): \($0.typeName.name)"}.joined(separator: ", ")
                        parameterType = "(\(joinedParameters))"
                    }
                    // If there is an init we use `ParameterFactory` so we can specify the parameters we have to supply to the init.
                    lines.append("public var \(registrationName): ParameterFactory<\(parameterType), \(type.name)> {".indent(level: 1))
                    lines.append("self { _ in fatalError(\"\(type.name) not registered\") }".indent(level: 2))
                    lines.append("}".indent(level: 1))
                } else {
                    // If there is no init method in the protocol we can use the regular `Factory`
                    lines.append("public var \(registrationName): Factory<\(type.name)> {".indent(level: 1))
                    lines.append("self { fatalError(\"\(type.name) not registered\") }".indent(level: 2))
                    lines.append("}".indent(level: 1))
                }
            }
        }
        lines.append("}")
        lines.append(.emptyLine)

        if let customContainerName, let propertyWrapperName = annotations.propertyWrapperName {
            lines.append("@propertyWrapper public struct \(propertyWrapperName)<T> {")
            lines.append("private var injected: Injected<T>".indent())
            lines.append(.emptyLine)
            lines.append("public init(_ keyPath: KeyPath<\(customContainerName), Factory<T>>) {".indent())
            lines.append("self.injected = .init(keyPath)".indent(level: 2))
            lines.append("}".indent())
            lines.append(.emptyLine)
            lines.append("/// Manages the wrapped dependency.".indent())
            lines.append("public var wrappedValue: T {".indent())
            lines.append("get { return injected.wrappedValue }".indent(level: 2))
            lines.append("mutating set { injected.wrappedValue = newValue }".indent(level: 2))
            lines.append("}".indent())
            lines.append(.emptyLine)
            lines.append("/// Unwraps the property wrapper granting access to the resolve/reset function.".indent())
            lines.append("public var projectedValue: Injected<T> {".indent())
            lines.append("get { return injected.projectedValue }".indent(level: 2))
            lines.append("mutating set { injected.projectedValue = newValue }".indent(level: 2))
            lines.append("}".indent())
            lines.append(.emptyLine)
            lines.append("/// Grants access to the internal Factory.".indent())
            lines.append("public var factory: Factory<T> {".indent())
            lines.append("injected.factory".indent(level: 2))
            lines.append("}".indent())
            lines.append(.emptyLine)
            lines.append("/// Allows the user to force a Factory resolution at their discretion.".indent())
            lines.append("public mutating func resolve(reset options: FactoryResetOptions = .none) {".indent())
            lines.append("injected.resolve(reset: options)".indent(level: 2))
            lines.append("}".indent())
            lines.append("}")
            lines.append(.emptyLine)
        }

        return lines.joined(separator: .newLine) + .newLine
    }
}
