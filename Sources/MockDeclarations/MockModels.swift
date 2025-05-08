import NestedMockDeclarations
import Foundation

// sourcery: AutoStubbable
struct MockModelWithNestedModel {
    let id: Int
    let nested: SomeNestedModel
}

// sourcery: AutoStubbable
struct MockModelWithInitMethodDeclaration {
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
struct MockModelWithStubbablePropertyWithMultipleInitDeclaration {
    let property: MockModelWithInitMethodDeclaration
}

// sourcery: AutoStubbable
struct MockModelWithInitMethodAndImplicitlyUnwrappedOptionalDeclaration {
    let property: Int
    var implicitlyUnwrappedProperty: Int!

    init(property: Int) {
        self.property = property
    }
}

// sourcery: AutoStubbable
struct MockModelDeclaration {
    let property: Int
    let optionalProperty: String?
}

protocol SomeProtocol {
    var property: Int { get }
}

// sourcery: AutoStubbable
struct MockImplementingSomeProtocol: SomeProtocol {
    let property: Int
}

// sourcery: AutoStubbable
struct MockModelWithProtocolProperty {
    let property: SomeProtocol
}

// sourcery: AutoStubbable
struct MockModelWithClosure {
    let doSomething: (() -> Void)
}

// sourcery: AutoStubbable
struct MockModelWithImplicitlyUnwrappedOptional {
    var property: Int
    var implicitlyUnwrappedProperty: Int!
}

// sourcery: AutoStubbable
struct MockModelWithOpaqueTypes {
    
    let opagueType: any OpaqueType
    let optionalOpagueType: (any OpaqueType)?
    let closureWithOpagueType: (any OpaqueType) -> Void
    let closureWithOptionalOpagueType: ((any OpaqueType)?) -> Void
    let optionalClosureWithOpagueType: ((any OpaqueType) -> Void)?
    let closureWithOpagueReturnType: () -> any OpaqueType
    let closureWithOptionalOpagueReturnType: () -> (any OpaqueType)?
}

// sourcery: AutoStubbable
struct MockUnnamedExternalParameter {

    let string: String
    let secondString: String

    init(
        _ firstValue: String,
        secondValue: String
    ) {
        self.string = firstValue
        self.secondString = secondValue
    }
}

// sourcery: AutoStubbable
struct MockModelWithMeasurements {
    let duration: Measurement<UnitDuration>
    let length: Measurement<UnitLength>
    let temperature: Measurement<UnitTemperature>
}
