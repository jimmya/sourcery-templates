// Generated using Sourcery 2.1.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

@testable import MockDeclarations
import Foundation

internal extension MockDomainModelDeclaration {
    static func stub(
        property: Int = 0,
        optionalProperty: String? = nil,
        opagueType: OpaqueType = DefaultOpaqueTypeMock(),
        optionalOpagueType: OpaqueType? = nil,
        closure: (String) -> Void = { .init() } ,
        optionalClosure: ((String) -> Void)? = nil,
        closureWithOpagueType: (OpaqueType) -> Void = { .init() } ,
        closureWithOptionalOpagueType: (OpaqueType?) -> Void = { .init() } ,
        optionalClosureWithOpagueType: ((OpaqueType) -> Void)? = nil
    ) -> MockDomainModelDeclaration {
        MockDomainModelDeclaration(
            property: property,
            optionalProperty: optionalProperty,
            opagueType: opagueType,
            optionalOpagueType: optionalOpagueType,
            closure: closure,
            optionalClosure: optionalClosure,
            closureWithOpagueType: closureWithOpagueType,
            closureWithOptionalOpagueType: closureWithOptionalOpagueType,
            optionalClosureWithOpagueType: optionalClosureWithOpagueType
        )
    }
}
internal extension MockModelDeclaration {
    static func stub(
        property: Int = 0,
        optionalProperty: String? = nil
    ) -> MockModelDeclaration {
        MockModelDeclaration(
            property: property,
            optionalProperty: optionalProperty
        )
    }
}
internal extension MockModelWithInitMethodDeclaration {
    static func stub0(
        property: Int = 0,
        somesome: String? = nil
    ) -> MockModelWithInitMethodDeclaration {
        MockModelWithInitMethodDeclaration(
            property: property,
            somesome: somesome
        )
    }
    static func stub1(
        property: Int = 0,
        optionalProperty: String? = nil
    ) -> MockModelWithInitMethodDeclaration {
        MockModelWithInitMethodDeclaration(
            property: property,
            optionalProperty: optionalProperty
        )
    }
    static func stub2(
        property: Int = 0,
        failableOptionalProperty: String? = nil
    ) -> MockModelWithInitMethodDeclaration? {
        MockModelWithInitMethodDeclaration(
            property: property,
            failableOptionalProperty: failableOptionalProperty
        )
    }
}