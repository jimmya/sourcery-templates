// Generated using Sourcery 2.2.6 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

@testable import MockDeclarations
import Foundation
import NestedMockDeclarations

internal extension MockImplementingSomeProtocol {
    static func stub(
        property: Int = 0
    ) -> MockImplementingSomeProtocol {
        MockImplementingSomeProtocol(
            property: property
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

internal extension MockModelWithClosure {
    static func stub(
        doSomething: @escaping () -> Void = { }
    ) -> MockModelWithClosure {
        MockModelWithClosure(
            doSomething: doSomething
        )
    }
}

internal extension MockModelWithImplicitlyUnwrappedOptional {
    static func stub(
        property: Int = 0,
        implicitlyUnwrappedProperty: Int = 0
    ) -> MockModelWithImplicitlyUnwrappedOptional {
        MockModelWithImplicitlyUnwrappedOptional(
            property: property,
            implicitlyUnwrappedProperty: implicitlyUnwrappedProperty
        )
    }
}

internal extension MockModelWithInitMethodAndImplicitlyUnwrappedOptionalDeclaration {
    static func stub(
        property: Int = 0,
        implicitlyUnwrappedProperty: Int = 0
    ) -> MockModelWithInitMethodAndImplicitlyUnwrappedOptionalDeclaration {
        var object = MockModelWithInitMethodAndImplicitlyUnwrappedOptionalDeclaration(
            property: property
        )
        object.implicitlyUnwrappedProperty = implicitlyUnwrappedProperty
        return object
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

internal extension MockModelWithNestedModel {
    static func stub(
        id: Int = 0,
        nested: SomeNestedModel = SomeNestedModel.stub()
    ) -> MockModelWithNestedModel {
        MockModelWithNestedModel(
            id: id,
            nested: nested
        )
    }
}

internal extension MockModelWithOpaqueTypes {
    static func stub(
        opagueType: any OpaqueType = DefaultOpaqueTypeMock(),
        optionalOpagueType: (any OpaqueType)? = nil,
        closureWithOpagueType: @escaping (any OpaqueType) -> Void = { _ in },
        closureWithOptionalOpagueType: @escaping ((any OpaqueType)?) -> Void = { _ in },
        optionalClosureWithOpagueType: ((any OpaqueType) -> Void)? = nil,
        closureWithOpagueReturnType: @escaping () -> any OpaqueType = { DefaultOpaqueTypeMock() },
        closureWithOptionalOpagueReturnType: @escaping () -> (any OpaqueType)? = { nil }
    ) -> MockModelWithOpaqueTypes {
        MockModelWithOpaqueTypes(
            opagueType: opagueType,
            optionalOpagueType: optionalOpagueType,
            closureWithOpagueType: closureWithOpagueType,
            closureWithOptionalOpagueType: closureWithOptionalOpagueType,
            optionalClosureWithOpagueType: optionalClosureWithOpagueType,
            closureWithOpagueReturnType: closureWithOpagueReturnType,
            closureWithOptionalOpagueReturnType: closureWithOptionalOpagueReturnType
        )
    }
}

internal extension MockModelWithProtocolProperty {
    static func stub(
        property: SomeProtocol = MockImplementingSomeProtocol.stub()
    ) -> MockModelWithProtocolProperty {
        MockModelWithProtocolProperty(
            property: property
        )
    }
}

internal extension MockModelWithStubbablePropertyWithMultipleInitDeclaration {
    static func stub(
        property: MockModelWithInitMethodDeclaration = MockModelWithInitMethodDeclaration.stub0()
    ) -> MockModelWithStubbablePropertyWithMultipleInitDeclaration {
        MockModelWithStubbablePropertyWithMultipleInitDeclaration(
            property: property
        )
    }
}

internal extension MockUnnamedExternalParameter {
    static func stub(
        firstValue: String = "",
        secondValue: String = ""
    ) -> MockUnnamedExternalParameter {
        MockUnnamedExternalParameter(
            firstValue,
            secondValue: secondValue
        )
    }
}

// swiftlint:disable all
