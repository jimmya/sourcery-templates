// sourcery: AutoStubbable
struct MockDomainModelWithInitMethodDeclaration {
    let property: Int
    let optionalProperty: String?

    init(property: Int, somesome optionalProperty: String?) {
        self.property = property
        self.optionalProperty = optionalProperty
    }

    init(property: Int, optionalProperty: String?) {
        self.property = property
        self.optionalProperty = optionalProperty
    }

    init?(property: Int, failableOptionalProperty: String?) {
        guard let failableOptionalProperty else {
            return nil
        }
        self.property = property
        self.optionalProperty = failableOptionalProperty
    }
}

// sourcery: AutoStubbable
struct MockDomainModelDeclaration {
    let property: Int
    let optionalProperty: String?
}
