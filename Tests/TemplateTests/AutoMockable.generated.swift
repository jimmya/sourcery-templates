// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

@testable import MockDeclarations
import Foundation
import XCTest

class DefaultMockProtocolDeclarationMock: MockProtocolDeclaration {

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

    var invokedMethod = false
    var invokedMethodCount = 0
    var invokedMethodParameters: (property: Int, optionalProperty: Int?, closureProperty: (Bool, Int) -> Int)?
    var invokedMethodParametersList: [(property: Int, optionalProperty: Int?, closureProperty: (Bool, Int) -> Int)] = []
    var stubbedMethodClosurePropertyResult: (Bool, Int)?
    var stubbedMethodResult: Int! = 0
    var invokedMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    func method(property: Int, optionalProperty: Int?, closureProperty: @escaping (Bool, Int) -> Int) -> Int {
        defer { invokedMethodExpectation.fulfill() }
        invokedMethod = true
        invokedMethodCount += 1
        invokedMethodParameters = (property: property, optionalProperty: optionalProperty, closureProperty: closureProperty)
        invokedMethodParametersList.append((property: property, optionalProperty: optionalProperty, closureProperty: closureProperty))
        if let result = stubbedMethodClosurePropertyResult {
            _ = closureProperty(result.0, result.1)
        }
        return stubbedMethodResult
    }
}