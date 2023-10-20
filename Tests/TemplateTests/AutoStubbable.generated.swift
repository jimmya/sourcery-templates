<<<<<<< HEAD
// Generated using Sourcery 2.1.1 — https://github.com/krzysztofzablocki/Sourcery
=======
// Generated using Sourcery 2.0.3 — https://github.com/krzysztofzablocki/Sourcery
>>>>>>> main
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

internal extension MockModelWithClosure {
    static func stub(
        doSomething: @escaping () -> Void = {  } 
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

// swiftlint:disable all
