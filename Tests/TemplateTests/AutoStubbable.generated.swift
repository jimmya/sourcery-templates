// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

@testable import MockDeclarations
import Foundation

internal extension MockDomainModelDeclaration {
    static func stub(
        property: Int = 0,
        optionalProperty: String? = nil
    ) -> MockDomainModelDeclaration {
        MockDomainModelDeclaration(
            property: property,
            optionalProperty: optionalProperty
        )
    }
}
internal extension MockDomainModelWithInitMethodDeclaration {
    static func stub0(
        property: Int = 0,
        somesome: String? = nil
    ) -> MockDomainModelWithInitMethodDeclaration {
        MockDomainModelWithInitMethodDeclaration(
            property: property,
            somesome: somesome
        )
    }
    static func stub1(
        property: Int = 0,
        optionalProperty: String? = nil
    ) -> MockDomainModelWithInitMethodDeclaration {
        MockDomainModelWithInitMethodDeclaration(
            property: property,
            optionalProperty: optionalProperty
        )
    }
    static func stub2(
        property: Int = 0,
        failableOptionalProperty: String? = nil
    ) -> MockDomainModelWithInitMethodDeclaration? {
        MockDomainModelWithInitMethodDeclaration(
            property: property,
            failableOptionalProperty: failableOptionalProperty
        )
    }
}