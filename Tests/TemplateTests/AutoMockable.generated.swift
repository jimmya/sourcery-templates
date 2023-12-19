// Generated using Sourcery 2.1.2 — https://github.com/krzysztofzablocki/Sourcery
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

internal class DefaultMockProtocolWithOpaqueTypesMock: MockProtocolWithOpaqueTypes {

    internal var invokedImmutableOpaqueObjectGetter = false
    internal var invokedImmutableOpaqueObjectGetterCount = 0
    internal var stubbedImmutableOpaqueObject: (any OpaqueType)! = DefaultOpaqueTypeMock()

    internal var immutableOpaqueObject: any OpaqueType {
        invokedImmutableOpaqueObjectGetter = true
        invokedImmutableOpaqueObjectGetterCount += 1
        return stubbedImmutableOpaqueObject
    }

    internal var invokedImmutableOptionalOpaqueObjectGetter = false
    internal var invokedImmutableOptionalOpaqueObjectGetterCount = 0
    internal var stubbedImmutableOptionalOpaqueObject: (any OpaqueType)?

    internal var immutableOptionalOpaqueObject: (any OpaqueType)? {
        invokedImmutableOptionalOpaqueObjectGetter = true
        invokedImmutableOptionalOpaqueObjectGetterCount += 1
        return stubbedImmutableOptionalOpaqueObject
    }

    internal var invokedImmutableClosureParameterGetter = false
    internal var invokedImmutableClosureParameterGetterCount = 0
    internal var stubbedImmutableClosureParameter: (((any OpaqueType)?) -> Void)!

    internal var immutableClosureParameter: ((any OpaqueType)?) -> Void {
        invokedImmutableClosureParameterGetter = true
        invokedImmutableClosureParameterGetterCount += 1
        return stubbedImmutableClosureParameter
    }

    internal var invokedImmutableClosureOpaqueReturnTypeGetter = false
    internal var invokedImmutableClosureOpaqueReturnTypeGetterCount = 0
    internal var stubbedImmutableClosureOpaqueReturnType: (() -> (any OpaqueType)?)!

    internal var immutableClosureOpaqueReturnType: () -> (any OpaqueType)? {
        invokedImmutableClosureOpaqueReturnTypeGetter = true
        invokedImmutableClosureOpaqueReturnTypeGetterCount += 1
        return stubbedImmutableClosureOpaqueReturnType
    }

    internal var invokedImmutableClosureOptionalOpaqueReturnTypeGetter = false
    internal var invokedImmutableClosureOptionalOpaqueReturnTypeGetterCount = 0
    internal var stubbedImmutableClosureOptionalOpaqueReturnType: (((any OpaqueType)?) -> Void)?

    internal var immutableClosureOptionalOpaqueReturnType: (((any OpaqueType)?) -> Void)? {
        invokedImmutableClosureOptionalOpaqueReturnTypeGetter = true
        invokedImmutableClosureOptionalOpaqueReturnTypeGetterCount += 1
        return stubbedImmutableClosureOptionalOpaqueReturnType
    }

    internal var invokedImmutableOptionalClosureParameterReturnTypeGetter = false
    internal var invokedImmutableOptionalClosureParameterReturnTypeGetterCount = 0
    internal var stubbedImmutableOptionalClosureParameterReturnType: (() -> (any OpaqueType)?)?

    internal var immutableOptionalClosureParameterReturnType: (() -> (any OpaqueType)?)? {
        invokedImmutableOptionalClosureParameterReturnTypeGetter = true
        invokedImmutableOptionalClosureParameterReturnTypeGetterCount += 1
        return stubbedImmutableOptionalClosureParameterReturnType
    }

    internal var invokedMutableOpaqueObjectSetter = false
    internal var invokedMutableOpaqueObjectSetterCount = 0
    internal var invokedMutableOpaqueObject: (any OpaqueType)?
    internal var invokedMutableOpaqueObjectList: [any OpaqueType] = []
    internal var invokedMutableOpaqueObjectGetter = false
    internal var invokedMutableOpaqueObjectGetterCount = 0
    internal var stubbedMutableOpaqueObject: (any OpaqueType)! = DefaultOpaqueTypeMock()

    internal var mutableOpaqueObject: any OpaqueType {
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

    internal var invokedMutableOptionalOpaqueObjectSetter = false
    internal var invokedMutableOptionalOpaqueObjectSetterCount = 0
    internal var invokedMutableOptionalOpaqueObject: (any OpaqueType)?
    internal var invokedMutableOptionalOpaqueObjectList: [(any OpaqueType)?] = []
    internal var invokedMutableOptionalOpaqueObjectGetter = false
    internal var invokedMutableOptionalOpaqueObjectGetterCount = 0
    internal var stubbedMutableOptionalOpaqueObject: (any OpaqueType)?

    internal var mutableOptionalOpaqueObject: (any OpaqueType)? {
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

    internal var invokedMutableClosureParameterSetter = false
    internal var invokedMutableClosureParameterSetterCount = 0
    internal var invokedMutableClosureParameter: (((any OpaqueType)?) -> Void)?
    internal var invokedMutableClosureParameterList: [((any OpaqueType)?) -> Void] = []
    internal var invokedMutableClosureParameterGetter = false
    internal var invokedMutableClosureParameterGetterCount = 0
    internal var stubbedMutableClosureParameter: (((any OpaqueType)?) -> Void)!

    internal var mutableClosureParameter: ((any OpaqueType)?) -> Void {
        get {
            invokedMutableClosureParameterGetter = true
            invokedMutableClosureParameterGetterCount += 1
            return stubbedMutableClosureParameter
        }
        set {
            invokedMutableClosureParameterSetter = true
            invokedMutableClosureParameterSetterCount += 1
            invokedMutableClosureParameter = newValue
            invokedMutableClosureParameterList.append(newValue)
        }
    }

    internal var invokedMutableOptionalClosureParameterSetter = false
    internal var invokedMutableOptionalClosureParameterSetterCount = 0
    internal var invokedMutableOptionalClosureParameter: (((any OpaqueType)?) -> Void)?
    internal var invokedMutableOptionalClosureParameterList: [(((any OpaqueType)?) -> Void)?] = []
    internal var invokedMutableOptionalClosureParameterGetter = false
    internal var invokedMutableOptionalClosureParameterGetterCount = 0
    internal var stubbedMutableOptionalClosureParameter: (((any OpaqueType)?) -> Void)?

    internal var mutableOptionalClosureParameter: (((any OpaqueType)?) -> Void)? {
        get {
            invokedMutableOptionalClosureParameterGetter = true
            invokedMutableOptionalClosureParameterGetterCount += 1
            return stubbedMutableOptionalClosureParameter
        }
        set {
            invokedMutableOptionalClosureParameterSetter = true
            invokedMutableOptionalClosureParameterSetterCount += 1
            invokedMutableOptionalClosureParameter = newValue
            invokedMutableOptionalClosureParameterList.append(newValue)
        }
    }

    internal init() { }

    internal var invokedSomeOpaqueClosureParameter: Bool { invokedSomeOpaqueClosureParameterCount > 0 }
    internal var invokedSomeOpaqueClosureParameterCount = 0
    internal var stubbedSomeOpaqueClosureParameterCompletionResult: (any OpaqueType)?
    internal var invokedSomeOpaqueClosureParameterExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func someOpaqueClosureParameter(completion: (any OpaqueType) -> Void) {
        defer { invokedSomeOpaqueClosureParameterExpectation.fulfill() }
        invokedSomeOpaqueClosureParameterCount += 1
        if let result = stubbedSomeOpaqueClosureParameterCompletionResult {
            completion(result)
        }
    }

    internal var invokedSomeOpaqueParameterFunction: Bool { invokedSomeOpaqueParameterFunctionCount > 0 }
    internal var invokedSomeOpaqueParameterFunctionCount = 0
    internal var invokedSomeOpaqueParameterFunctionParameters: (opaqueObject: any OpaqueType, Void)?
    internal var invokedSomeOpaqueParameterFunctionParametersList: [(opaqueObject: any OpaqueType, Void)] = []
    internal var invokedSomeOpaqueParameterFunctionExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func someOpaqueParameterFunction(opaqueObject: any OpaqueType) {
        defer { invokedSomeOpaqueParameterFunctionExpectation.fulfill() }
        invokedSomeOpaqueParameterFunctionCount += 1
        invokedSomeOpaqueParameterFunctionParameters = (opaqueObject: opaqueObject, ())
        invokedSomeOpaqueParameterFunctionParametersList.append((opaqueObject: opaqueObject, ()))
    }

    internal var invokedSomeOpaqueReturningFunction: Bool { invokedSomeOpaqueReturningFunctionCount > 0 }
    internal var invokedSomeOpaqueReturningFunctionCount = 0
    internal var stubbedSomeOpaqueReturningFunctionResult: (any OpaqueType)!
    internal var invokedSomeOpaqueReturningFunctionExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func someOpaqueReturningFunction() -> any OpaqueType {
        defer { invokedSomeOpaqueReturningFunctionExpectation.fulfill() }
        invokedSomeOpaqueReturningFunctionCount += 1
        return stubbedSomeOpaqueReturningFunctionResult
    }

    internal var invokedSomeOptionalOpaqueClosureReturnType: Bool { invokedSomeOptionalOpaqueClosureReturnTypeCount > 0 }
    internal var invokedSomeOptionalOpaqueClosureReturnTypeCount = 0
    internal var shouldInvokeSomeOptionalOpaqueClosureReturnTypeCompletion = false
    internal var invokedSomeOptionalOpaqueClosureReturnTypeExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func someOptionalOpaqueClosureReturnType(completion: () -> any OpaqueType) {
        defer { invokedSomeOptionalOpaqueClosureReturnTypeExpectation.fulfill() }
        invokedSomeOptionalOpaqueClosureReturnTypeCount += 1
        if shouldInvokeSomeOptionalOpaqueClosureReturnTypeCompletion {
            _ = completion()
        }
    }

    internal var invokedSomeOptionalOpaqueOptionalClosureParameter: Bool { invokedSomeOptionalOpaqueOptionalClosureParameterCount > 0 }
    internal var invokedSomeOptionalOpaqueOptionalClosureParameterCount = 0
    internal var stubbedSomeOptionalOpaqueOptionalClosureParameterCompletionResult: ((any OpaqueType)?, Void)?
    internal var invokedSomeOptionalOpaqueOptionalClosureParameterExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func someOptionalOpaqueOptionalClosureParameter(completion: (((any OpaqueType)?) -> Void)?) {
        defer { invokedSomeOptionalOpaqueOptionalClosureParameterExpectation.fulfill() }
        invokedSomeOptionalOpaqueOptionalClosureParameterCount += 1
        if let result = stubbedSomeOptionalOpaqueOptionalClosureParameterCompletionResult {
            completion?(result.0)
        }
    }

    internal var invokedSomeOptionalOpaqueOptionalClosureReturnType: Bool { invokedSomeOptionalOpaqueOptionalClosureReturnTypeCount > 0 }
    internal var invokedSomeOptionalOpaqueOptionalClosureReturnTypeCount = 0
    internal var shouldInvokeSomeOptionalOpaqueOptionalClosureReturnTypeCompletion = false
    internal var invokedSomeOptionalOpaqueOptionalClosureReturnTypeExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func someOptionalOpaqueOptionalClosureReturnType(completion: (() -> (any OpaqueType)?)?) {
        defer { invokedSomeOptionalOpaqueOptionalClosureReturnTypeExpectation.fulfill() }
        invokedSomeOptionalOpaqueOptionalClosureReturnTypeCount += 1
        if shouldInvokeSomeOptionalOpaqueOptionalClosureReturnTypeCompletion {
            _ = completion?()
        }
    }

    internal var invokedSomeOptionalOpaqueParameterFunction: Bool { invokedSomeOptionalOpaqueParameterFunctionCount > 0 }
    internal var invokedSomeOptionalOpaqueParameterFunctionCount = 0
    internal var invokedSomeOptionalOpaqueParameterFunctionParameters: (opaqueObject: (any OpaqueType)?, Void)?
    internal var invokedSomeOptionalOpaqueParameterFunctionParametersList: [(opaqueObject: (any OpaqueType)?, Void)] = []
    internal var invokedSomeOptionalOpaqueParameterFunctionExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func someOptionalOpaqueParameterFunction(opaqueObject: (any OpaqueType)?) {
        defer { invokedSomeOptionalOpaqueParameterFunctionExpectation.fulfill() }
        invokedSomeOptionalOpaqueParameterFunctionCount += 1
        invokedSomeOptionalOpaqueParameterFunctionParameters = (opaqueObject: opaqueObject, ())
        invokedSomeOptionalOpaqueParameterFunctionParametersList.append((opaqueObject: opaqueObject, ()))
    }

    internal var invokedSomeOptionalOpaqueReturningFunction: Bool { invokedSomeOptionalOpaqueReturningFunctionCount > 0 }
    internal var invokedSomeOptionalOpaqueReturningFunctionCount = 0
    internal var stubbedSomeOptionalOpaqueReturningFunctionResult: (any OpaqueType)?
    internal var invokedSomeOptionalOpaqueReturningFunctionExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func someOptionalOpaqueReturningFunction() -> (any OpaqueType)? {
        defer { invokedSomeOptionalOpaqueReturningFunctionExpectation.fulfill() }
        invokedSomeOptionalOpaqueReturningFunctionCount += 1
        return stubbedSomeOptionalOpaqueReturningFunctionResult
    }
}

internal class DefaultMockProtocolWithOptionalClosureMethodMock: MockProtocolWithOptionalClosureMethod {

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

internal class DefaultOpaqueTypeMock: OpaqueType {

    internal init() { }
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
