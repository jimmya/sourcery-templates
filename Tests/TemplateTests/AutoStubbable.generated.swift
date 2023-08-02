// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

@testable import MockDeclarations
import Foundation

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
