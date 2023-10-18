// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

@testable import MockDeclarations
import Foundation

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