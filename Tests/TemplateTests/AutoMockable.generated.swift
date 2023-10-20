<<<<<<< HEAD
// Generated using Sourcery 2.1.1 — https://github.com/krzysztofzablocki/Sourcery
=======
// Generated using Sourcery 2.0.3 — https://github.com/krzysztofzablocki/Sourcery
>>>>>>> main
// DO NOT EDIT
// swiftlint:disable all

@testable import MockDeclarations
import Foundation
import XCTest

internal class DefaultBasicRequestExecutorLogicMock: BasicRequestExecutorLogic {

    internal init() { }

    internal var stubbedExecuteThrowableError: Error?
    internal var invokedExecute: Bool { invokedExecuteCount > 0 }
    internal var invokedExecuteCount = 0
    internal var invokedExecuteParameters: (urlRequest: URLRequest, Void)?
    internal var invokedExecuteParametersList: [(urlRequest: URLRequest, Void)] = []
    internal var invokedExecuteExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func execute(_ urlRequest: URLRequest) async throws {
        defer { invokedExecuteExpectation.fulfill() }
        invokedExecuteCount += 1
        invokedExecuteParameters = (urlRequest: urlRequest, ())
        invokedExecuteParametersList.append((urlRequest: urlRequest, ()))
        if let error = stubbedExecuteThrowableError {
            throw error
        }
    }

    internal var stubbedExecuteUrlRequestThrowableError: Error?
    internal var invokedExecuteUrlRequest: Bool { invokedExecuteUrlRequestCount > 0 }
    internal var invokedExecuteUrlRequestCount = 0
    internal var invokedExecuteUrlRequestParameters: (urlRequest: URLRequest, Void)?
    internal var invokedExecuteUrlRequestParametersList: [(urlRequest: URLRequest, Void)] = []
    internal var stubbedExecuteUrlRequestResult: Decodable!
    internal var invokedExecuteUrlRequestExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func execute<Response>(_ urlRequest: URLRequest) async throws -> Response where Response: Decodable {
        defer { invokedExecuteUrlRequestExpectation.fulfill() }
        invokedExecuteUrlRequestCount += 1
        invokedExecuteUrlRequestParameters = (urlRequest: urlRequest, ())
        invokedExecuteUrlRequestParametersList.append((urlRequest: urlRequest, ()))
        if let error = stubbedExecuteUrlRequestThrowableError {
            throw error
        }
        return stubbedExecuteUrlRequestResult as! Response
    }

    internal var stubbedExecuteUrlRequestDecoderThrowableError: Error?
    internal var invokedExecuteUrlRequestDecoder: Bool { invokedExecuteUrlRequestDecoderCount > 0 }
    internal var invokedExecuteUrlRequestDecoderCount = 0
    internal var invokedExecuteUrlRequestDecoderParameters: (urlRequest: URLRequest, decoder: JSONDecoder)?
    internal var invokedExecuteUrlRequestDecoderParametersList: [(urlRequest: URLRequest, decoder: JSONDecoder)] = []
    internal var stubbedExecuteUrlRequestDecoderResult: Decodable!
    internal var invokedExecuteUrlRequestDecoderExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func execute<Response>(_ urlRequest: URLRequest, decoder: JSONDecoder) async throws -> Response where Response: Decodable {
        defer { invokedExecuteUrlRequestDecoderExpectation.fulfill() }
        invokedExecuteUrlRequestDecoderCount += 1
        invokedExecuteUrlRequestDecoderParameters = (urlRequest: urlRequest, decoder: decoder)
        invokedExecuteUrlRequestDecoderParametersList.append((urlRequest: urlRequest, decoder: decoder))
        if let error = stubbedExecuteUrlRequestDecoderThrowableError {
            throw error
        }
        return stubbedExecuteUrlRequestDecoderResult as! Response
    }
}

internal class DefaultMockProtocolWithClosureMethodMock: MockProtocolWithClosureMethod {

    internal init() { }

    internal var invokedMethod: Bool { invokedMethodCount > 0 }
    internal var invokedMethodCount = 0
    internal var invokedMethodParameters: (closureProperty: (Bool, Int) -> Int, Void)?
    internal var invokedMethodParametersList: [(closureProperty: (Bool, Int) -> Int, Void)] = []
    internal var stubbedMethodClosurePropertyResult: (Bool, Int)?
    internal var invokedMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func method(closureProperty: @escaping (Bool, Int) -> Int) {
        defer { invokedMethodExpectation.fulfill() }
        invokedMethodCount += 1
        invokedMethodParameters = (closureProperty: closureProperty, ())
        invokedMethodParametersList.append((closureProperty: closureProperty, ()))
        if let result = stubbedMethodClosurePropertyResult {
            _ = closureProperty(result.0, result.1)
        }
    }
}

internal class DefaultMockProtocolWithGenericFunctionMock: MockProtocolWithGenericFunction {

    internal init() { }

    internal var invokedDoSomething: Bool { invokedDoSomethingCount > 0 }
    internal var invokedDoSomethingCount = 0
    internal var invokedDoSomethingParameters: (parameter: Any, anotherParameter: Int)?
    internal var invokedDoSomethingParametersList: [(parameter: Any, anotherParameter: Int)] = []
    internal var invokedDoSomethingExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func doSomething<T>(parameter: T, anotherParameter: Int) {
        defer { invokedDoSomethingExpectation.fulfill() }
        invokedDoSomethingCount += 1
        invokedDoSomethingParameters = (parameter: parameter, anotherParameter: anotherParameter)
        invokedDoSomethingParametersList.append((parameter: parameter, anotherParameter: anotherParameter))
    }
}

internal class DefaultMockProtocolWithGenericInheritanceDeclarationMock: SomeType, MockProtocolWithGenericInheritanceDeclaration {

    internal var invokedInitParameters: (someParameter: Int, Void)?
    internal var invokedInitParametersList: [(someParameter: Int, Void)] = []

    internal required init(someParameter: Int) {
        invokedInitParameters = (someParameter: someParameter, ())
        invokedInitParametersList.append((someParameter: someParameter, ()))
    }

    internal var invokedInitSomeFailableParameterParameters: (someFailableParameter: Int, Void)?
    internal var invokedInitSomeFailableParameterParametersList: [(someFailableParameter: Int, Void)] = []

    internal required init(someFailableParameter: Int) {
        invokedInitSomeFailableParameterParameters = (someFailableParameter: someFailableParameter, ())
        invokedInitSomeFailableParameterParametersList.append((someFailableParameter: someFailableParameter, ()))
    }

    internal var invokedMethod: Bool { invokedMethodCount > 0 }
    internal var invokedMethodCount = 0
    internal var invokedMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func method() {
        defer { invokedMethodExpectation.fulfill() }
        invokedMethodCount += 1
    }
}

internal class DefaultMockProtocolWithMultipleMethodsMock: MockProtocolWithMultipleMethods {

    internal init() { }

    internal var invokedAnotherMethod: Bool { invokedAnotherMethodCount > 0 }
    internal var invokedAnotherMethodCount = 0
    internal var invokedAnotherMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func anotherMethod() {
        defer { invokedAnotherMethodExpectation.fulfill() }
        invokedAnotherMethodCount += 1
    }

    internal var stubbedAnotherMethodWithThrowableError: Error?
    internal var invokedAnotherMethodWith: Bool { invokedAnotherMethodWithCount > 0 }
    internal var invokedAnotherMethodWithCount = 0
    internal var invokedAnotherMethodWithParameters: (input: String, Void)?
    internal var invokedAnotherMethodWithParametersList: [(input: String, Void)] = []
    internal var invokedAnotherMethodWithExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func anotherMethod(with input: String) async throws {
        defer { invokedAnotherMethodWithExpectation.fulfill() }
        invokedAnotherMethodWithCount += 1
        invokedAnotherMethodWithParameters = (input: input, ())
        invokedAnotherMethodWithParametersList.append((input: input, ()))
        if let error = stubbedAnotherMethodWithThrowableError {
            throw error
        }
    }
}

<<<<<<< HEAD
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
=======
internal class DefaultMockProtocolWithOptionalClosureMethodMock: MockProtocolWithOptionalClosureMethod {
>>>>>>> main

    internal init() { }

    internal var invokedMethod: Bool { invokedMethodCount > 0 }
    internal var invokedMethodCount = 0
    internal var stubbedMethodClosurePropertyResult: (Bool, Int)?
    internal var invokedMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func method(closureProperty: ((Bool, Int) -> Int)?) {
        defer { invokedMethodExpectation.fulfill() }
        invokedMethodCount += 1
        if let result = stubbedMethodClosurePropertyResult {
            _ = closureProperty?(result.0, result.1)
        }
    }
}

internal class DefaultMockProtocolWithPropertiesMock: MockProtocolWithProperties {

    internal var invokedImmutablePropertyGetter = false
    internal var invokedImmutablePropertyGetterCount = 0
    internal var stubbedImmutableProperty: Int! = 0

    internal var immutableProperty: Int {
        invokedImmutablePropertyGetter = true
        invokedImmutablePropertyGetterCount += 1
        return stubbedImmutableProperty
    }

    internal var invokedMutablePropertySetter = false
    internal var invokedMutablePropertySetterCount = 0
    internal var invokedMutableProperty: Int?
    internal var invokedMutablePropertyList: [Int] = []
    internal var invokedMutablePropertyGetter = false
    internal var invokedMutablePropertyGetterCount = 0
    internal var stubbedMutableProperty: Int! = 0

    internal var mutableProperty: Int {
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

    internal var invokedImmutableOptionalPropertyGetter = false
    internal var invokedImmutableOptionalPropertyGetterCount = 0
    internal var stubbedImmutableOptionalProperty: Int?

    internal var immutableOptionalProperty: Int? {
        invokedImmutableOptionalPropertyGetter = true
        invokedImmutableOptionalPropertyGetterCount += 1
        return stubbedImmutableOptionalProperty
    }

    internal var invokedMutableOptionalPropertySetter = false
    internal var invokedMutableOptionalPropertySetterCount = 0
    internal var invokedMutableOptionalProperty: Int?
    internal var invokedMutableOptionalPropertyList: [Int?] = []
    internal var invokedMutableOptionalPropertyGetter = false
    internal var invokedMutableOptionalPropertyGetterCount = 0
    internal var stubbedMutableOptionalProperty: Int?

    internal var mutableOptionalProperty: Int? {
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

    internal init() { }
}

internal class DefaultMockProtocolWithPropertyAndMethodMock: MockProtocolWithPropertyAndMethod {

    internal var invokedPropertyGetter = false
    internal var invokedPropertyGetterCount = 0
    internal var stubbedProperty: String! = ""

    internal var property: String {
        invokedPropertyGetter = true
        invokedPropertyGetterCount += 1
        return stubbedProperty
    }

    internal init() { }

    internal var invokedMethod: Bool { invokedMethodCount > 0 }
    internal var invokedMethodCount = 0
    internal var invokedMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func method() {
        defer { invokedMethodExpectation.fulfill() }
        invokedMethodCount += 1
    }
}

<<<<<<< HEAD
class DefaultOpaqueTypeMock: OpaqueType {

}
=======
public class DefaultMockProtocolWithPublicAccessLevelMock: MockProtocolWithPublicAccessLevel {

    public init() { }

    public var invokedMethod: Bool { invokedMethodCount > 0 }
    public var invokedMethodCount = 0
    public var invokedMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    public func method() {
        defer { invokedMethodExpectation.fulfill() }
        invokedMethodCount += 1
    }
}

internal final class DefaultMockProtocolWithReturnSelfMock: MockProtocolWithReturnSelf {

    internal init() { }

    internal var invokedMethod: Bool { invokedMethodCount > 0 }
    internal var invokedMethodCount = 0
    internal var stubbedMethodResult: DefaultMockProtocolWithReturnSelfMock!
    internal var invokedMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func method() -> DefaultMockProtocolWithReturnSelfMock {
        defer { invokedMethodExpectation.fulfill() }
        invokedMethodCount += 1
        return stubbedMethodResult
    }
}

internal class DefaultURLSessionLogicMock: URLSessionLogic {

    internal init() { }

    internal var stubbedDataThrowableError: Error?
    internal var invokedData: Bool { invokedDataCount > 0 }
    internal var invokedDataCount = 0
    internal var invokedDataParameters: (request: URLRequest, Void)?
    internal var invokedDataParametersList: [(request: URLRequest, Void)] = []
    internal var stubbedDataResult: (Data, URLResponse)!
    internal var invokedDataExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        defer { invokedDataExpectation.fulfill() }
        invokedDataCount += 1
        invokedDataParameters = (request: request, ())
        invokedDataParametersList.append((request: request, ()))
        if let error = stubbedDataThrowableError {
            throw error
        }
        return stubbedDataResult
    }
}
// swiftlint:enable all
>>>>>>> main
