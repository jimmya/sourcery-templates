import SourceryRuntime

enum AutoStubbable {
    static func generate(types: Types, annotations: Annotations) -> String {
        var lines: [String] = []
        lines.append(contentsOf: annotations.testableImports.map { "@testable import \($0)" })
        lines.append(contentsOf: annotations.imports.map { "import \($0)" })
        lines.append("")

        let sortedTypes = (types.structs + types.classes).sorted(by: { $0.name < $1.name }).filter(\.isAutoStubbable)
        sortedTypes.forEach { type in
            lines.append("\(type.accessLevel) extension \(type.name) {")
            let implicitlyUnwrappedVariables = type.storedVariables.filter(\.isImplicitlyUnwrappedOptional)
            type.initMethods.enumerated().forEach { index, method in
                lines.append("static func \(stubMethodName(index: index, count: type.initMethods.count))(".addingIndent())
                method.parameters.forEach { parameter in
                    lines.append("\(parameter.argumentLabel ?? parameter.name): \(parameter.typeName.generateStubbableName(type: parameter.type)) = \(parameter.typeName.generateDefaultValue(type: parameter.type, includeComplexType: true))".addingIndent(count: 2))
                }
                lines.append(") -> \(type.name)".addingIndent())
            }
            lines.append("}")
        }

        return lines.joined(separator: .newLine)
    }
}
//
//<%_ for (index, method) in type.initMethods.enumerated() { %>
//    <%_ let implicitlyUnwrappedVariables = type.storedVariables.filter { $0.isImplicitlyUnwrappedOptional } -%>
//    static func <%= stubMethodName(index: index, count: type.initMethods.count) %>(
//        <%_ for parameter in method.parameters { -%>
//            <%= parameter.name %>: <%= generateTypeName(typeName: parameter.typeName, type: parameter.type) %> = <%= generateDefaultValue(type: parameter.type, typeName: parameter.typeName, includeComplexType: true) %><% if parameter != method.parameters.last || !implicitlyUnwrappedVariables.isEmpty { %>,<% } %>
//            <%_ } -%>
//          <%_ for variable in implicitlyUnwrappedVariables { -%>
//              <%= variable.name %>: <%= generateTypeName(typeName: variable.typeName, type: variable.type) %> = <%= generateDefaultValue(type: variable.type, typeName: variable.typeName, includeComplexType: true) %><% if variable != implicitlyUnwrappedVariables.last { %>,<% } %>
//              <%_ } -%>
//    ) -> <%= type.name %><% if method.isFailableInitializer { %>?<% } %> {
//        <%= generateStubbableInit(objectType: type, parameterNames: method.parameters.map { $0.name }) %>
//        }
