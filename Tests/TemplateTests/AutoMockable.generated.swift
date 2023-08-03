// Generated using Sourcery 2.0.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

@testable import MockDeclarations
import Foundation
import XCTest

class DefaultMockProtocolWithClosureMethodMock: MockProtocolWithClosureMethod {

    var invokedMethod: Bool { invokedMethodCount > 0 }
    var invokedMethodCount = 0
    var invokedMethodParameters: (closureProperty: (Bool, Int) -> Int, Void)?
    var invokedMethodParametersList: [(closureProperty: (Bool, Int) -> Int, Void)] = []
    var stubbedMethodClosurePropertyResult: (Bool, Int)?
    var invokedMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    func method(closureProperty: @escaping (Bool, Int) -> Int) {
        defer { invokedMethodExpectation.fulfill() }
        invokedMethodCount += 1
        invokedMethodParameters = (closureProperty: closureProperty, ())
        invokedMethodParametersList.append((closureProperty: closureProperty, ()))
        if let result = stubbedMethodClosurePropertyResult {
            _ = closureProperty(result.0, result.1)
        }
    }
}

class DefaultMockProtocolWithGenericFunctionMock: MockProtocolWithGenericFunction {

    var invokedDoSomething: Bool { invokedDoSomethingCount > 0 }
    var invokedDoSomethingCount = 0
    var invokedDoSomethingParameters: (parameter: Any, anotherParameter: Any)?
    var invokedDoSomethingParametersList: [(parameter: Any, anotherParameter: Any)] = []
    var invokedDoSomethingExpectation = XCTestExpectation(description: "\(#function) expectation")

    func doSomething<T>(parameter: T, anotherParameter: Int) {
        defer { invokedDoSomethingExpectation.fulfill() }
        invokedDoSomethingCount += 1
        invokedDoSomethingParameters = (parameter: parameter, anotherParameter: anotherParameter)
        invokedDoSomethingParametersList.append((parameter: parameter, anotherParameter: anotherParameter))
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

    var invokedMethod: Bool { invokedMethodCount > 0 }
    var invokedMethodCount = 0
    var invokedMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    func method() {
        defer { invokedMethodExpectation.fulfill() }
        invokedMethodCount += 1
    }
}

class DefaultMockProtocolWithMultipleMethodsMock: MockProtocolWithMultipleMethods {

    var invokedAnotherMethod: Bool { invokedAnotherMethodCount > 0 }
    var invokedAnotherMethodCount = 0
    var invokedAnotherMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    func anotherMethod() {
        defer { invokedAnotherMethodExpectation.fulfill() }
        invokedAnotherMethodCount += 1
    }

    var stubbedAnotherMethodWithThrowableError: Error?
    var invokedAnotherMethodWith: Bool { invokedAnotherMethodWithCount > 0 }
    var invokedAnotherMethodWithCount = 0
    var invokedAnotherMethodWithParameters: (input: String, Void)?
    var invokedAnotherMethodWithParametersList: [(input: String, Void)] = []
    var invokedAnotherMethodWithExpectation = XCTestExpectation(description: "\(#function) expectation")

    func anotherMethod(with input: String) async throws {
        defer { invokedAnotherMethodWithExpectation.fulfill() }
        if let error = stubbedAnotherMethodWithThrowableError {
            throw error
        }
        invokedAnotherMethodWithCount += 1
        invokedAnotherMethodWithParameters = (input: input, ())
        invokedAnotherMethodWithParametersList.append((input: input, ()))
    }
}

class DefaultMockProtocolWithOptionalClosureMethodMock: MockProtocolWithOptionalClosureMethod {

    var invokedMethod: Bool { invokedMethodCount > 0 }
    var invokedMethodCount = 0
    var stubbedMethodClosurePropertyResult: (Bool, Int)?
    var invokedMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    func method(closureProperty: ((Bool, Int) -> Int)?) {
        defer { invokedMethodExpectation.fulfill() }
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

    var invokedMethod: Bool { invokedMethodCount > 0 }
    var invokedMethodCount = 0
    var invokedMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    func method() {
        defer { invokedMethodExpectation.fulfill() }
        invokedMethodCount += 1
    }
}

final class DefaultMockProtocolWithReturnSelfMock: MockProtocolWithReturnSelf {

    var invokedMethod: Bool { invokedMethodCount > 0 }
    var invokedMethodCount = 0
    var stubbedMethodResult: DefaultMockProtocolWithReturnSelfMock!
    var invokedMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    func method() -> DefaultMockProtocolWithReturnSelfMock {
        defer { invokedMethodExpectation.fulfill() }
        invokedMethodCount += 1
        return stubbedMethodResult
    }
}
// swiftlint:enable all
