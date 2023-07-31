// sourcery: AutoStubbable
struct MockDomainModelDeclaration {
    let property: Int
    let optionalProperty: String?

    init(property: Int, somesome optionalProperty: String?) {
        self.property = property
        self.optionalProperty = optionalProperty
    }
}
