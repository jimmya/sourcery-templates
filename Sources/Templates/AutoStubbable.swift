import SourceryRuntime

enum AutoStubbable {
    static func generate(types: Types, annotations: Annotations) -> String {
        var lines: [String] = []
        lines.append(contentsOf: annotations.testableImports.map { "@testable import \($0)" })
        lines.append(contentsOf: annotations.imports.map { "import \($0)" })
        lines.append("")

        let sortedTypes = (types.structs + types.classes).sorted(by: { $0.name < $1.name }).filter(\.isAutoStubbable)
        let types = sortedTypes.map { type in
            type.generateStub()
        }.joined(separator: [.emptyLine])
        lines.append(contentsOf: types)
        
        return lines.joined(separator: .newLine)
    }
}

extension Type {
    func generateStub() -> [String] {
        var lines: [String] = []
        lines.append("\(accessLevel) extension \(name) {")

        let initMethodLines = initMethods.enumerated().map { index, method in
            var lines: [String] = []
            lines.append("static func \(stubMethodName(index: index, count: initMethods.count))(".addingIndent())
            let methodParameterLines = method.parameters.map { parameter in
                "\(parameter.argumentLabel ?? parameter.name): \(parameter.typeName.generateStubbableName(type: parameter.type)) = \(parameter.typeName.generateDefaultValue(type: parameter.type, includeComplexType: true))".addingIndent(count: 2)
            }
            let joinedMethodParameterLines = methodParameterLines.joined(separator: ",\n")
            lines.append(joinedMethodParameterLines)
            lines.append(") -> \(name)\(method.isFailableInitializer ? "?" : "") {".addingIndent())
            lines.append("\(name)(".addingIndent(count: 2))
            let methodAssignmentLines = method.parameters.map { parameter in
                "\(parameter.argumentLabel ?? parameter.name): \(parameter.argumentLabel ?? parameter.name)".addingIndent(count: 3)
            }
            let joinedMethodAssignmentLines = methodAssignmentLines.joined(separator: ",\n")
            lines.append(joinedMethodAssignmentLines)
            lines.append(")".addingIndent(count: 2))
            lines.append("}".addingIndent())
            return lines
        }
        lines.append(contentsOf: initMethodLines.joined(separator: [.emptyLine]))
        
        if initMethods.isEmpty {
            lines.append("static func \(stubMethodName(index: 0, count: 1))(".addingIndent())
            let availableVariables = storedVariables.filter { !$0.hasDefaultValue }
            let variableLines = availableVariables.map { variable in
                "\(variable.name): \(variable.typeName.generateStubbableName(type: variable.type)) = \(variable.typeName.generateDefaultValue(type: variable.type, includeComplexType: true))".addingIndent(count: 2)
            }
            let joinedVariableLines = variableLines.joined(separator: ",\n")
            lines.append(joinedVariableLines)
            lines.append(") -> \(name) {".addingIndent())
            lines.append("\(name)(".addingIndent(count: 2))
            let variableAssignmentLines = availableVariables.map { variable in
                "\(variable.name): \(variable.name)".addingIndent(count: 3)
            }
            let joinedVariableAssignmentLines = variableAssignmentLines.joined(separator: ",\n")
            lines.append(joinedVariableAssignmentLines)
            lines.append(")".addingIndent(count: 2))
            lines.append("}".addingIndent())
        }
        lines.append("}")
        return lines
    }
}

// TODO: Move and improve this stuff
extension Type {
    var initMethods: [Method] {
        methods.filter { ($0.isInitializer || $0.isFailableInitializer) && !$0.isConvenienceInitializer }
    }
}

extension Variable {
    var hasDefaultValue: Bool {
        defaultValue != nil
    }
}

func stubMethodName(index: Int, count: Int) -> String {
    count > 1 ? "stub\(index)" : "stub"
}

func generateStubbableInit(objectType: Type, variables: [Variable]) -> String {
    guard !variables.isEmpty else {
        return "\(objectType.name)()"
    }

    let initVariables = variables.filter { !$0.isImplicitlyUnwrappedOptional && !$0.hasDefaultValue }

    return generateStubbableInit(objectType: objectType, parameterNames: initVariables.map { $0.name })
}

func generateStubbableInit(objectType: Type, parameterNames: [String]) -> String {
    let implicitlyUnwrappedVariables = objectType.storedVariables.filter { $0.isImplicitlyUnwrappedOptional }
    let containsImplicitlyUnwrappedOptionals = !implicitlyUnwrappedVariables.isEmpty

    guard !parameterNames.isEmpty || containsImplicitlyUnwrappedOptionals else {
        return "\(objectType.name)()"
    }

    var objectInit: String = containsImplicitlyUnwrappedOptionals ? "let object = \(objectType.name)(" : "\(objectType.name)("

    if parameterNames.isEmpty {
        objectInit.append(")")
    } else {
        parameterNames.enumerated().forEach { index, element in
            let isLastElement = index + 1 ==  parameterNames.count
            let suffix: String = isLastElement ? "" : ","
            let line = "\(element): \(element)\(suffix)".addingIndent(count: 3)
            objectInit.append(contentsOf: "\n\(line)")

            if isLastElement {
                objectInit.append(contentsOf: "\n")
                objectInit.append(contentsOf: ")".addingIndent(count: 2))
            }
        }
    }

    if containsImplicitlyUnwrappedOptionals {
        for variable in implicitlyUnwrappedVariables {
            objectInit.append(contentsOf: "\n")
            objectInit.append(contentsOf: "object.\(variable.name) = \(variable.name)".addingIndent(count: 2))
        }
        objectInit.append(contentsOf: "\n")
        objectInit.append(contentsOf: "return object".addingIndent(count: 2))
    }

    return objectInit
}
