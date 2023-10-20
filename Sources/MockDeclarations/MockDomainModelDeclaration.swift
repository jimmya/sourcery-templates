// sourcery: AutoStubbable
struct MockDomainModelDeclaration {

    let property: Int
    let optionalProperty: String?
    let opagueType: any OpaqueType
    let optionalOpagueType: (any OpaqueType)?
    let closure: (String) -> Void
    let optionalClosure: ((String) -> Void)?
    let closureWithOpagueType: (any OpaqueType) -> Void
    let closureWithOptionalOpagueType: ((any OpaqueType)?) -> Void
    let optionalClosureWithOpagueType: ((any OpaqueType) -> Void)?

    init(property: Int, optionalProperty: String? = nil, opagueType: OpaqueType, optionalOpagueType: (OpaqueType)? = nil, closure: @escaping (String) -> Void, optionalClosure: ((String) -> Void)? = nil, closureWithOpagueType: @escaping (OpaqueType) -> Void, closureWithOptionalOpagueType: @escaping ((OpaqueType)?) -> Void, optionalClosureWithOpagueType: ((OpaqueType) -> Void)? = nil) {
        self.property = property
        self.optionalProperty = optionalProperty
        self.opagueType = opagueType
        self.optionalOpagueType = optionalOpagueType
        self.closure = closure
        self.optionalClosure = optionalClosure
        self.closureWithOpagueType = closureWithOpagueType
        self.closureWithOptionalOpagueType = closureWithOptionalOpagueType
        self.optionalClosureWithOpagueType = optionalClosureWithOpagueType
    }
}
