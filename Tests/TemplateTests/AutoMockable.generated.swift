// Generated using Sourcery 2.1.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

@testable import MockDeclarations
import Foundation
import XCTest

class DefaultMockProtocolWithClosureMethodMock: MockProtocolWithClosureMethod {

    var invokedMethod = false
    var invokedMethodCount = 0
    var invokedMethodParameters: (closureProperty: (Bool, Int) -> Int, Void)?
    var invokedMethodParametersList: [(closureProperty: (Bool, Int) -> Int, Void)] = []
    var stubbedMethodClosurePropertyResult: (Bool, Int)?
    var invokedMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    func method(closureProperty: @escaping (Bool, Int) -> Int) {
        defer { invokedMethodExpectation.fulfill() }
        invokedMethod = true
        invokedMethodCount += 1
        invokedMethodParameters = (closureProperty: closureProperty, ())
        invokedMethodParametersList.append((closureProperty: closureProperty, ()))
        if let result = stubbedMethodClosurePropertyResult {
            _ = closureProperty(result.0, result.1)
        }
    }
}

class DefaultMockProtocolWithGenericInheritanceDeclarationMock: SomeType, MockProtocolWithGenericInheritanceDeclaration {

    var invokedInitParameters: (someParameter: Int, Void)?
    var invokedInitParametersList: [(someParameter: Int, Void)] = []

    required init(someParameter: Int) {
        invokedInitParameters = (someParameter: someParameter, ())
        invokedInitParametersList.append((someParameter: someParameter, ()))
    }

    var invokedInitSomeFailableParameterParameters: (someFailableParameter: Int, Void)?
    var invokedInitSomeFailableParameterParametersList: [(someFailableParameter: Int, Void)] = []

    required init(someFailableParameter: Int) {
        invokedInitSomeFailableParameterParameters = (someFailableParameter: someFailableParameter, ())
        invokedInitSomeFailableParameterParametersList.append((someFailableParameter: someFailableParameter, ()))
    }

    var invokedMethod = false
    var invokedMethodCount = 0
    var invokedMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    func method() {
        defer { invokedMethodExpectation.fulfill() }
        invokedMethod = true
        invokedMethodCount += 1
    }
}

class DefaultMockProtocolWithMultipleMethodsMock: MockProtocolWithMultipleMethods {

    var invokedAnotherMethod = false
    var invokedAnotherMethodCount = 0
    var invokedAnotherMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    func anotherMethod() {
        defer { invokedAnotherMethodExpectation.fulfill() }
        invokedAnotherMethod = true
        invokedAnotherMethodCount += 1
    }

    var stubbedAnotherMethodWithThrowableError: Error?
    var invokedAnotherMethodWith = false
    var invokedAnotherMethodWithCount = 0
    var invokedAnotherMethodWithParameters: (input: String, Void)?
    var invokedAnotherMethodWithParametersList: [(input: String, Void)] = []
    var invokedAnotherMethodWithExpectation = XCTestExpectation(description: "\(#function) expectation")

    func anotherMethod(with input: String) async throws {
        defer { invokedAnotherMethodWithExpectation.fulfill() }
        if let error = stubbedAnotherMethodWithThrowableError {
            throw error
        }
        invokedAnotherMethodWith = true
        invokedAnotherMethodWithCount += 1
        invokedAnotherMethodWithParameters = (input: input, ())
        invokedAnotherMethodWithParametersList.append((input: input, ()))
    }
}

class DefaultMockProtocolWithOpaqueTypesMock: MockProtocolWithOpaqueTypes {

    var invokedImmutableOpaqueObjectGetter = false
    var invokedImmutableOpaqueObjectGetterCount = 0
    var stubbedImmutableOpaqueObject: (any OpaqueType)!

    var immutableOpaqueObject: any OpaqueType {
        invokedImmutableOpaqueObjectGetter = true
        invokedImmutableOpaqueObjectGetterCount += 1
        return stubbedImmutableOpaqueObject
    }

    var invokedImmutableOptionalOpaqueObjectGetter = false
    var invokedImmutableOptionalOpaqueObjectGetterCount = 0
    var stubbedImmutableOptionalOpaqueObject: any OpaqueType

    var immutableOptionalOpaqueObject: (any OpaqueType)? {
        invokedImmutableOptionalOpaqueObjectGetter = true
        invokedImmutableOptionalOpaqueObjectGetterCount += 1
        return stubbedImmutableOptionalOpaqueObject
    }

    var invokedMutableOpaqueObjectSetter = false
    var invokedMutableOpaqueObjectSetterCount = 0
    var invokedMutableOpaqueObject: any OpaqueType
    var invokedMutableOpaqueObjectList: [any OpaqueType] = []
    var invokedMutableOpaqueObjectGetter = false
    var invokedMutableOpaqueObjectGetterCount = 0
    var stubbedMutableOpaqueObject: (any OpaqueType)!

    var mutableOpaqueObject: any OpaqueType {
        get {
            invokedMutableOpaqueObjectGetter = true
            invokedMutableOpaqueObjectGetterCount += 1
            return stubbedMutableOpaqueObject
        }
        set {
            invokedMutableOpaqueObjectSetter = true
            invokedMutableOpaqueObjectSetterCount += 1
            invokedMutableOpaqueObject = newValue
            invokedMutableOpaqueObjectList.append(newValue)
        }
    }

    var invokedMutableOptionalOpaqueObjectSetter = false
    var invokedMutableOptionalOpaqueObjectSetterCount = 0
    var invokedMutableOptionalOpaqueObject: (any OpaqueType)?
    var invokedMutableOptionalOpaqueObjectList: [(any OpaqueType)?] = []
    var invokedMutableOptionalOpaqueObjectGetter = false
    var invokedMutableOptionalOpaqueObjectGetterCount = 0
    var stubbedMutableOptionalOpaqueObject: any OpaqueType

    var mutableOptionalOpaqueObject: (any OpaqueType)? {
        get {
            invokedMutableOptionalOpaqueObjectGetter = true
            invokedMutableOptionalOpaqueObjectGetterCount += 1
            return stubbedMutableOptionalOpaqueObject
        }
        set {
            invokedMutableOptionalOpaqueObjectSetter = true
            invokedMutableOptionalOpaqueObjectSetterCount += 1
            invokedMutableOptionalOpaqueObject = newValue
            invokedMutableOptionalOpaqueObjectList.append(newValue)
        }
    }

    var invokedSomeOpaqueParameterFunction = false
    var invokedSomeOpaqueParameterFunctionCount = 0
    var invokedSomeOpaqueParameterFunctionParameters: (opaqueObject: any OpaqueType, Void)?
    var invokedSomeOpaqueParameterFunctionParametersList: [(opaqueObject: any OpaqueType, Void)] = []
    var invokedSomeOpaqueParameterFunctionExpectation = XCTestExpectation(description: "\(#function) expectation")

    func someOpaqueParameterFunction(opaqueObject: any OpaqueType) {
        defer { invokedSomeOpaqueParameterFunctionExpectation.fulfill() }
        invokedSomeOpaqueParameterFunction = true
        invokedSomeOpaqueParameterFunctionCount += 1
        invokedSomeOpaqueParameterFunctionParameters = (opaqueObject: opaqueObject, ())
        invokedSomeOpaqueParameterFunctionParametersList.append((opaqueObject: opaqueObject, ()))
    }

    var invokedSomeOpaqueReturningFunction = false
    var invokedSomeOpaqueReturningFunctionCount = 0
    var stubbedSomeOpaqueReturningFunctionResult: (any OpaqueType)!
    var invokedSomeOpaqueReturningFunctionExpectation = XCTestExpectation(description: "\(#function) expectation")

    func someOpaqueReturningFunction() -> any OpaqueType {
        defer { invokedSomeOpaqueReturningFunctionExpectation.fulfill() }
        invokedSomeOpaqueReturningFunction = true
        invokedSomeOpaqueReturningFunctionCount += 1
        return stubbedSomeOpaqueReturningFunctionResult
    }

    var invokedSomeOptionalOpaqueParameterFunction = false
    var invokedSomeOptionalOpaqueParameterFunctionCount = 0
    var invokedSomeOptionalOpaqueParameterFunctionParameters: (opaqueObject: (any OpaqueType)?, Void)?
    var invokedSomeOptionalOpaqueParameterFunctionParametersList: [(opaqueObject: (any OpaqueType)?, Void)] = []
    var invokedSomeOptionalOpaqueParameterFunctionExpectation = XCTestExpectation(description: "\(#function) expectation")

    func someOptionalOpaqueParameterFunction(opaqueObject: (any OpaqueType)?) {
        defer { invokedSomeOptionalOpaqueParameterFunctionExpectation.fulfill() }
        invokedSomeOptionalOpaqueParameterFunction = true
        invokedSomeOptionalOpaqueParameterFunctionCount += 1
        invokedSomeOptionalOpaqueParameterFunctionParameters = (opaqueObject: opaqueObject, ())
        invokedSomeOptionalOpaqueParameterFunctionParametersList.append((opaqueObject: opaqueObject, ()))
    }

    var invokedSomeOptionalOpaqueReturningFunction = false
    var invokedSomeOptionalOpaqueReturningFunctionCount = 0
    var stubbedSomeOptionalOpaqueReturningFunctionResult: (any OpaqueType)?
    var invokedSomeOptionalOpaqueReturningFunctionExpectation = XCTestExpectation(description: "\(#function) expectation")

    func someOptionalOpaqueReturningFunction() -> (any OpaqueType)? {
        defer { invokedSomeOptionalOpaqueReturningFunctionExpectation.fulfill() }
        invokedSomeOptionalOpaqueReturningFunction = true
        invokedSomeOptionalOpaqueReturningFunctionCount += 1
        return stubbedSomeOptionalOpaqueReturningFunctionResult
    }
}

class DefaultMockProtocolWithOptionalClosureMethodMock: MockProtocolWithOptionalClosureMethod {

    var invokedMethod = false
    var invokedMethodCount = 0
    var stubbedMethodClosurePropertyResult: (Bool, Int)?
    var invokedMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    func method(closureProperty: ((Bool, Int) -> Int)?) {
        defer { invokedMethodExpectation.fulfill() }
        invokedMethod = true
        invokedMethodCount += 1
        if let result = stubbedMethodClosurePropertyResult {
            _ = closureProperty?(result.0, result.1)
        }
    }
}

class DefaultMockProtocolWithPropertiesMock: MockProtocolWithProperties {

    var invokedImmutablePropertyGetter = false
    var invokedImmutablePropertyGetterCount = 0
    var stubbedImmutableProperty: Int! = 0

    var immutableProperty: Int {
        invokedImmutablePropertyGetter = true
        invokedImmutablePropertyGetterCount += 1
        return stubbedImmutableProperty
    }

    var invokedMutablePropertySetter = false
    var invokedMutablePropertySetterCount = 0
    var invokedMutableProperty: Int?
    var invokedMutablePropertyList: [Int] = []
    var invokedMutablePropertyGetter = false
    var invokedMutablePropertyGetterCount = 0
    var stubbedMutableProperty: Int! = 0

    var mutableProperty: Int {
        get {
            invokedMutablePropertyGetter = true
            invokedMutablePropertyGetterCount += 1
            return stubbedMutableProperty
        }
        set {
            invokedMutablePropertySetter = true
            invokedMutablePropertySetterCount += 1
            invokedMutableProperty = newValue
            invokedMutablePropertyList.append(newValue)
        }
    }

    var invokedImmutableOptionalPropertyGetter = false
    var invokedImmutableOptionalPropertyGetterCount = 0
    var stubbedImmutableOptionalProperty: Int?

    var immutableOptionalProperty: Int? {
        invokedImmutableOptionalPropertyGetter = true
        invokedImmutableOptionalPropertyGetterCount += 1
        return stubbedImmutableOptionalProperty
    }

    var invokedMutableOptionalPropertySetter = false
    var invokedMutableOptionalPropertySetterCount = 0
    var invokedMutableOptionalProperty: Int?
    var invokedMutableOptionalPropertyList: [Int?] = []
    var invokedMutableOptionalPropertyGetter = false
    var invokedMutableOptionalPropertyGetterCount = 0
    var stubbedMutableOptionalProperty: Int?

    var mutableOptionalProperty: Int? {
        get {
            invokedMutableOptionalPropertyGetter = true
            invokedMutableOptionalPropertyGetterCount += 1
            return stubbedMutableOptionalProperty
        }
        set {
            invokedMutableOptionalPropertySetter = true
            invokedMutableOptionalPropertySetterCount += 1
            invokedMutableOptionalProperty = newValue
            invokedMutableOptionalPropertyList.append(newValue)
        }
    }
}

class DefaultMockProtocolWithPropertyAndMethodMock: MockProtocolWithPropertyAndMethod {

    var invokedPropertyGetter = false
    var invokedPropertyGetterCount = 0
    var stubbedProperty: String! = ""

    var property: String {
        invokedPropertyGetter = true
        invokedPropertyGetterCount += 1
        return stubbedProperty
    }

    var invokedMethod = false
    var invokedMethodCount = 0
    var invokedMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    func method() {
        defer { invokedMethodExpectation.fulfill() }
        invokedMethod = true
        invokedMethodCount += 1
    }
}

class DefaultOpaqueTypeMock: OpaqueType {

}
