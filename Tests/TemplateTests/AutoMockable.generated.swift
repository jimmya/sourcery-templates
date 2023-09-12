// Generated using Sourcery 2.0.3 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable all

@testable import MockDeclarations
import Foundation
import XCTest

internal class DefaultBasicRequestExecutorLogicMock: BasicRequestExecutorLogic {

    internal var stubbedExecuteURLRequestThrowableError: Error?
    internal var invokedExecuteURLRequest: Bool { invokedExecuteURLRequestCount > 0 }
    internal var invokedExecuteURLRequestCount = 0
    internal var invokedExecuteURLRequestParameters: (urlRequest: URLRequest, Void)?
    internal var invokedExecuteURLRequestParametersList: [(urlRequest: URLRequest, Void)] = []
    internal var invokedExecuteURLRequestExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func execute(_ urlRequest: URLRequest) async throws {
        defer { invokedExecuteURLRequestExpectation.fulfill() }
        invokedExecuteURLRequestCount += 1
        invokedExecuteURLRequestParameters = (urlRequest: urlRequest, ())
        invokedExecuteURLRequestParametersList.append((urlRequest: urlRequest, ()))
        if let error = stubbedExecuteURLRequestThrowableError {
            throw error
        }
    }

    internal var stubbedExecuteURLRequestResponseThrowableError: Error?
    internal var invokedExecuteURLRequestResponse: Bool { invokedExecuteURLRequestResponseCount > 0 }
    internal var invokedExecuteURLRequestResponseCount = 0
    internal var invokedExecuteURLRequestResponseParameters: (urlRequest: URLRequest, Void)?
    internal var invokedExecuteURLRequestResponseParametersList: [(urlRequest: URLRequest, Void)] = []
    internal var stubbedExecuteURLRequestResponseResult: Decodable!
    internal var invokedExecuteURLRequestResponseExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func execute<Response>(_ urlRequest: URLRequest) async throws -> Response where Response: Decodable {
        defer { invokedExecuteURLRequestResponseExpectation.fulfill() }
        invokedExecuteURLRequestResponseCount += 1
        invokedExecuteURLRequestResponseParameters = (urlRequest: urlRequest, ())
        invokedExecuteURLRequestResponseParametersList.append((urlRequest: urlRequest, ()))
        if let error = stubbedExecuteURLRequestResponseThrowableError {
            throw error
        }
        return stubbedExecuteURLRequestResponseResult as! Response
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

    required init(someParameter: Int) {
        invokedInitParameters = (someParameter: someParameter, ())
        invokedInitParametersList.append((someParameter: someParameter, ()))
    }

    internal var invokedInitSomeFailableParameterParameters: (someFailableParameter: Int, Void)?
    internal var invokedInitSomeFailableParameterParametersList: [(someFailableParameter: Int, Void)] = []

    required init(someFailableParameter: Int) {
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

internal class DefaultMockProtocolWithOptionalClosureMethodMock: MockProtocolWithOptionalClosureMethod {

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

    internal var invokedMethod: Bool { invokedMethodCount > 0 }
    internal var invokedMethodCount = 0
    internal var invokedMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func method() {
        defer { invokedMethodExpectation.fulfill() }
        invokedMethodCount += 1
    }
}

public class DefaultMockProtocolWithPublicAccessLevelMock: MockProtocolWithPublicAccessLevel {

    public var invokedMethod: Bool { invokedMethodCount > 0 }
    public var invokedMethodCount = 0
    public var invokedMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    public func method() {
        defer { invokedMethodExpectation.fulfill() }
        invokedMethodCount += 1
    }
}

internal final class DefaultMockProtocolWithReturnSelfMock: MockProtocolWithReturnSelf {

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
