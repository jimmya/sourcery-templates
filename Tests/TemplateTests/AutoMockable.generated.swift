// Generated using Sourcery 2.2.2 — https://github.com/krzysztofzablocki/Sourcery
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
    internal var stubbedExecuteUrlRequestResult: (any Decodable)!
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
    internal var stubbedExecuteUrlRequestDecoderResult: (any Decodable)!
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

    internal var invokedImmutableOpaqueClosureParameterGetter = false
    internal var invokedImmutableOpaqueClosureParameterGetterCount = 0
    internal var stubbedImmutableOpaqueClosureParameter: ((any OpaqueType) -> Void)!

    internal var immutableOpaqueClosureParameter: (any OpaqueType) -> Void {
        invokedImmutableOpaqueClosureParameterGetter = true
        invokedImmutableOpaqueClosureParameterGetterCount += 1
        return stubbedImmutableOpaqueClosureParameter
    }

    internal var invokedImmutableOptionalOpaqueClosureParameterGetter = false
    internal var invokedImmutableOptionalOpaqueClosureParameterGetterCount = 0
    internal var stubbedImmutableOptionalOpaqueClosureParameter: (((any OpaqueType)?) -> Void)!

    internal var immutableOptionalOpaqueClosureParameter: ((any OpaqueType)?) -> Void {
        invokedImmutableOptionalOpaqueClosureParameterGetter = true
        invokedImmutableOptionalOpaqueClosureParameterGetterCount += 1
        return stubbedImmutableOptionalOpaqueClosureParameter
    }

    internal var invokedImmutableClosureOpaqueReturnTypeGetter = false
    internal var invokedImmutableClosureOpaqueReturnTypeGetterCount = 0
    internal var stubbedImmutableClosureOpaqueReturnType: (() -> any OpaqueType)!

    internal var immutableClosureOpaqueReturnType: () -> any OpaqueType {
        invokedImmutableClosureOpaqueReturnTypeGetter = true
        invokedImmutableClosureOpaqueReturnTypeGetterCount += 1
        return stubbedImmutableClosureOpaqueReturnType
    }

    internal var invokedImmutableClosureOptionalOpaqueReturnTypeGetter = false
    internal var invokedImmutableClosureOptionalOpaqueReturnTypeGetterCount = 0
    internal var stubbedImmutableClosureOptionalOpaqueReturnType: (() -> (any OpaqueType)?)!

    internal var immutableClosureOptionalOpaqueReturnType: () -> (any OpaqueType)? {
        invokedImmutableClosureOptionalOpaqueReturnTypeGetter = true
        invokedImmutableClosureOptionalOpaqueReturnTypeGetterCount += 1
        return stubbedImmutableClosureOptionalOpaqueReturnType
    }

    internal var invokedImmutableOptionalClosureOpaqueParameterGetter = false
    internal var invokedImmutableOptionalClosureOpaqueParameterGetterCount = 0
    internal var stubbedImmutableOptionalClosureOpaqueParameter: ((any OpaqueType) -> Void)?

    internal var immutableOptionalClosureOpaqueParameter: ((any OpaqueType) -> Void)? {
        invokedImmutableOptionalClosureOpaqueParameterGetter = true
        invokedImmutableOptionalClosureOpaqueParameterGetterCount += 1
        return stubbedImmutableOptionalClosureOpaqueParameter
    }

    internal var invokedImmutableOptionalClosureOptionalOpaqueParameterGetter = false
    internal var invokedImmutableOptionalClosureOptionalOpaqueParameterGetterCount = 0
    internal var stubbedImmutableOptionalClosureOptionalOpaqueParameter: (((any OpaqueType)?) -> Void)?

    internal var immutableOptionalClosureOptionalOpaqueParameter: (((any OpaqueType)?) -> Void)? {
        invokedImmutableOptionalClosureOptionalOpaqueParameterGetter = true
        invokedImmutableOptionalClosureOptionalOpaqueParameterGetterCount += 1
        return stubbedImmutableOptionalClosureOptionalOpaqueParameter
    }

    internal var invokedImmutableOptionalClosureOpaqueReturnTypeGetter = false
    internal var invokedImmutableOptionalClosureOpaqueReturnTypeGetterCount = 0
    internal var stubbedImmutableOptionalClosureOpaqueReturnType: (() -> any OpaqueType)?

    internal var immutableOptionalClosureOpaqueReturnType: (() -> any OpaqueType)? {
        invokedImmutableOptionalClosureOpaqueReturnTypeGetter = true
        invokedImmutableOptionalClosureOpaqueReturnTypeGetterCount += 1
        return stubbedImmutableOptionalClosureOpaqueReturnType
    }

    internal var invokedImmutableOptionalClosureOpationalOpaqueReturnTypeGetter = false
    internal var invokedImmutableOptionalClosureOpationalOpaqueReturnTypeGetterCount = 0
    internal var stubbedImmutableOptionalClosureOpationalOpaqueReturnType: (() -> (any OpaqueType)?)?

    internal var immutableOptionalClosureOpationalOpaqueReturnType: (() -> (any OpaqueType)?)? {
        invokedImmutableOptionalClosureOpationalOpaqueReturnTypeGetter = true
        invokedImmutableOptionalClosureOpationalOpaqueReturnTypeGetterCount += 1
        return stubbedImmutableOptionalClosureOpationalOpaqueReturnType
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

    internal var invokedMutableClosureOpaqueParameterSetter = false
    internal var invokedMutableClosureOpaqueParameterSetterCount = 0
    internal var invokedMutableClosureOpaqueParameter: ((any OpaqueType) -> Void)?
    internal var invokedMutableClosureOpaqueParameterList: [(any OpaqueType) -> Void] = []
    internal var invokedMutableClosureOpaqueParameterGetter = false
    internal var invokedMutableClosureOpaqueParameterGetterCount = 0
    internal var stubbedMutableClosureOpaqueParameter: ((any OpaqueType) -> Void)!

    internal var mutableClosureOpaqueParameter: (any OpaqueType) -> Void {
        get {
            invokedMutableClosureOpaqueParameterGetter = true
            invokedMutableClosureOpaqueParameterGetterCount += 1
            return stubbedMutableClosureOpaqueParameter
        }
        set {
            invokedMutableClosureOpaqueParameterSetter = true
            invokedMutableClosureOpaqueParameterSetterCount += 1
            invokedMutableClosureOpaqueParameter = newValue
            invokedMutableClosureOpaqueParameterList.append(newValue)
        }
    }

    internal var invokedMutableClosureOptionalOpaqueParameterSetter = false
    internal var invokedMutableClosureOptionalOpaqueParameterSetterCount = 0
    internal var invokedMutableClosureOptionalOpaqueParameter: (((any OpaqueType)?) -> Void)?
    internal var invokedMutableClosureOptionalOpaqueParameterList: [((any OpaqueType)?) -> Void] = []
    internal var invokedMutableClosureOptionalOpaqueParameterGetter = false
    internal var invokedMutableClosureOptionalOpaqueParameterGetterCount = 0
    internal var stubbedMutableClosureOptionalOpaqueParameter: (((any OpaqueType)?) -> Void)!

    internal var mutableClosureOptionalOpaqueParameter: ((any OpaqueType)?) -> Void {
        get {
            invokedMutableClosureOptionalOpaqueParameterGetter = true
            invokedMutableClosureOptionalOpaqueParameterGetterCount += 1
            return stubbedMutableClosureOptionalOpaqueParameter
        }
        set {
            invokedMutableClosureOptionalOpaqueParameterSetter = true
            invokedMutableClosureOptionalOpaqueParameterSetterCount += 1
            invokedMutableClosureOptionalOpaqueParameter = newValue
            invokedMutableClosureOptionalOpaqueParameterList.append(newValue)
        }
    }

    internal var invokedMutableOptionalClosureOpaqueParameterSetter = false
    internal var invokedMutableOptionalClosureOpaqueParameterSetterCount = 0
    internal var invokedMutableOptionalClosureOpaqueParameter: ((any OpaqueType) -> Void)?
    internal var invokedMutableOptionalClosureOpaqueParameterList: [((any OpaqueType) -> Void)?] = []
    internal var invokedMutableOptionalClosureOpaqueParameterGetter = false
    internal var invokedMutableOptionalClosureOpaqueParameterGetterCount = 0
    internal var stubbedMutableOptionalClosureOpaqueParameter: ((any OpaqueType) -> Void)?

    internal var mutableOptionalClosureOpaqueParameter: ((any OpaqueType) -> Void)? {
        get {
            invokedMutableOptionalClosureOpaqueParameterGetter = true
            invokedMutableOptionalClosureOpaqueParameterGetterCount += 1
            return stubbedMutableOptionalClosureOpaqueParameter
        }
        set {
            invokedMutableOptionalClosureOpaqueParameterSetter = true
            invokedMutableOptionalClosureOpaqueParameterSetterCount += 1
            invokedMutableOptionalClosureOpaqueParameter = newValue
            invokedMutableOptionalClosureOpaqueParameterList.append(newValue)
        }
    }

    internal var invokedMutableOptionalClosureOptionalOpaqueParameterSetter = false
    internal var invokedMutableOptionalClosureOptionalOpaqueParameterSetterCount = 0
    internal var invokedMutableOptionalClosureOptionalOpaqueParameter: (((any OpaqueType)?) -> Void)?
    internal var invokedMutableOptionalClosureOptionalOpaqueParameterList: [(((any OpaqueType)?) -> Void)?] = []
    internal var invokedMutableOptionalClosureOptionalOpaqueParameterGetter = false
    internal var invokedMutableOptionalClosureOptionalOpaqueParameterGetterCount = 0
    internal var stubbedMutableOptionalClosureOptionalOpaqueParameter: (((any OpaqueType)?) -> Void)?

    internal var mutableOptionalClosureOptionalOpaqueParameter: (((any OpaqueType)?) -> Void)? {
        get {
            invokedMutableOptionalClosureOptionalOpaqueParameterGetter = true
            invokedMutableOptionalClosureOptionalOpaqueParameterGetterCount += 1
            return stubbedMutableOptionalClosureOptionalOpaqueParameter
        }
        set {
            invokedMutableOptionalClosureOptionalOpaqueParameterSetter = true
            invokedMutableOptionalClosureOptionalOpaqueParameterSetterCount += 1
            invokedMutableOptionalClosureOptionalOpaqueParameter = newValue
            invokedMutableOptionalClosureOptionalOpaqueParameterList.append(newValue)
        }
    }

    internal var invokedMutableOptionalClosureOpaqueReturnTypeSetter = false
    internal var invokedMutableOptionalClosureOpaqueReturnTypeSetterCount = 0
    internal var invokedMutableOptionalClosureOpaqueReturnType: (() -> any OpaqueType)?
    internal var invokedMutableOptionalClosureOpaqueReturnTypeList: [(() -> any OpaqueType)?] = []
    internal var invokedMutableOptionalClosureOpaqueReturnTypeGetter = false
    internal var invokedMutableOptionalClosureOpaqueReturnTypeGetterCount = 0
    internal var stubbedMutableOptionalClosureOpaqueReturnType: (() -> any OpaqueType)?

    internal var mutableOptionalClosureOpaqueReturnType: (() -> any OpaqueType)? {
        get {
            invokedMutableOptionalClosureOpaqueReturnTypeGetter = true
            invokedMutableOptionalClosureOpaqueReturnTypeGetterCount += 1
            return stubbedMutableOptionalClosureOpaqueReturnType
        }
        set {
            invokedMutableOptionalClosureOpaqueReturnTypeSetter = true
            invokedMutableOptionalClosureOpaqueReturnTypeSetterCount += 1
            invokedMutableOptionalClosureOpaqueReturnType = newValue
            invokedMutableOptionalClosureOpaqueReturnTypeList.append(newValue)
        }
    }

    internal var invokedMutableOptionalClosureOptionalOpaqueReturnTypeSetter = false
    internal var invokedMutableOptionalClosureOptionalOpaqueReturnTypeSetterCount = 0
    internal var invokedMutableOptionalClosureOptionalOpaqueReturnType: (() -> (any OpaqueType)?)?
    internal var invokedMutableOptionalClosureOptionalOpaqueReturnTypeList: [(() -> (any OpaqueType)?)?] = []
    internal var invokedMutableOptionalClosureOptionalOpaqueReturnTypeGetter = false
    internal var invokedMutableOptionalClosureOptionalOpaqueReturnTypeGetterCount = 0
    internal var stubbedMutableOptionalClosureOptionalOpaqueReturnType: (() -> (any OpaqueType)?)?

    internal var mutableOptionalClosureOptionalOpaqueReturnType: (() -> (any OpaqueType)?)? {
        get {
            invokedMutableOptionalClosureOptionalOpaqueReturnTypeGetter = true
            invokedMutableOptionalClosureOptionalOpaqueReturnTypeGetterCount += 1
            return stubbedMutableOptionalClosureOptionalOpaqueReturnType
        }
        set {
            invokedMutableOptionalClosureOptionalOpaqueReturnTypeSetter = true
            invokedMutableOptionalClosureOptionalOpaqueReturnTypeSetterCount += 1
            invokedMutableOptionalClosureOptionalOpaqueReturnType = newValue
            invokedMutableOptionalClosureOptionalOpaqueReturnTypeList.append(newValue)
        }
    }

    internal init() { }

    internal var invokedMethodWithGenericConstraint: Bool { invokedMethodWithGenericConstraintCount > 0 }
    internal var invokedMethodWithGenericConstraintCount = 0
    internal var invokedMethodWithGenericConstraintParameters: (property: Any, values: Set<String>)?
    internal var invokedMethodWithGenericConstraintParametersList: [(property: Any, values: Set<String>)] = []
    internal var stubbedMethodWithGenericConstraintResult: (any Equatable)!
    internal var invokedMethodWithGenericConstraintExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func methodWithGenericConstraint<T: Equatable>(property: SomeGenericStruct<T>, values: Set<String>) -> T {
        defer { invokedMethodWithGenericConstraintExpectation.fulfill() }
        invokedMethodWithGenericConstraintCount += 1
        invokedMethodWithGenericConstraintParameters = (property: property, values: values)
        invokedMethodWithGenericConstraintParametersList.append((property: property, values: values))
        return stubbedMethodWithGenericConstraintResult as! T
    }

    internal var invokedSomeClosureOpaqueParameter: Bool { invokedSomeClosureOpaqueParameterCount > 0 }
    internal var invokedSomeClosureOpaqueParameterCount = 0
    internal var stubbedSomeClosureOpaqueParameterCompletionResult: (any OpaqueType)?
    internal var invokedSomeClosureOpaqueParameterExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func someClosureOpaqueParameter(completion: (any OpaqueType) -> Void) {
        defer { invokedSomeClosureOpaqueParameterExpectation.fulfill() }
        invokedSomeClosureOpaqueParameterCount += 1
        if let result = stubbedSomeClosureOpaqueParameterCompletionResult {
            completion(result)
        }
    }

    internal var invokedSomeClosureOpaqueReturnType: Bool { invokedSomeClosureOpaqueReturnTypeCount > 0 }
    internal var invokedSomeClosureOpaqueReturnTypeCount = 0
    internal var shouldInvokeSomeClosureOpaqueReturnTypeCompletion = false
    internal var invokedSomeClosureOpaqueReturnTypeExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func someClosureOpaqueReturnType(completion: () -> any OpaqueType) {
        defer { invokedSomeClosureOpaqueReturnTypeExpectation.fulfill() }
        invokedSomeClosureOpaqueReturnTypeCount += 1
        if shouldInvokeSomeClosureOpaqueReturnTypeCompletion {
            _ = completion()
        }
    }

    internal var invokedSomeClosureOptionalOpaqueParameter: Bool { invokedSomeClosureOptionalOpaqueParameterCount > 0 }
    internal var invokedSomeClosureOptionalOpaqueParameterCount = 0
    internal var stubbedSomeClosureOptionalOpaqueParameterCompletionResult: ((any OpaqueType)?, Void)?
    internal var invokedSomeClosureOptionalOpaqueParameterExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func someClosureOptionalOpaqueParameter(completion: ((any OpaqueType)?) -> Void) {
        defer { invokedSomeClosureOptionalOpaqueParameterExpectation.fulfill() }
        invokedSomeClosureOptionalOpaqueParameterCount += 1
        if let result = stubbedSomeClosureOptionalOpaqueParameterCompletionResult {
            completion(result.0)
        }
    }

    internal var invokedSomeClosureOptionalOpaqueReturnType: Bool { invokedSomeClosureOptionalOpaqueReturnTypeCount > 0 }
    internal var invokedSomeClosureOptionalOpaqueReturnTypeCount = 0
    internal var shouldInvokeSomeClosureOptionalOpaqueReturnTypeCompletion = false
    internal var invokedSomeClosureOptionalOpaqueReturnTypeExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func someClosureOptionalOpaqueReturnType(completion: () -> (any OpaqueType)?) {
        defer { invokedSomeClosureOptionalOpaqueReturnTypeExpectation.fulfill() }
        invokedSomeClosureOptionalOpaqueReturnTypeCount += 1
        if shouldInvokeSomeClosureOptionalOpaqueReturnTypeCompletion {
            _ = completion()
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

    internal var invokedSomeOptionalClosureOpaqueParameter: Bool { invokedSomeOptionalClosureOpaqueParameterCount > 0 }
    internal var invokedSomeOptionalClosureOpaqueParameterCount = 0
    internal var stubbedSomeOptionalClosureOpaqueParameterCompletionResult: (any OpaqueType)?
    internal var invokedSomeOptionalClosureOpaqueParameterExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func someOptionalClosureOpaqueParameter(completion: ((any OpaqueType) -> Void)?) {
        defer { invokedSomeOptionalClosureOpaqueParameterExpectation.fulfill() }
        invokedSomeOptionalClosureOpaqueParameterCount += 1
        if let result = stubbedSomeOptionalClosureOpaqueParameterCompletionResult {
            completion?(result)
        }
    }

    internal var invokedSomeOptionalClosureOpaqueReturnType: Bool { invokedSomeOptionalClosureOpaqueReturnTypeCount > 0 }
    internal var invokedSomeOptionalClosureOpaqueReturnTypeCount = 0
    internal var shouldInvokeSomeOptionalClosureOpaqueReturnTypeCompletion = false
    internal var invokedSomeOptionalClosureOpaqueReturnTypeExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func someOptionalClosureOpaqueReturnType(completion: (() -> any OpaqueType)?) {
        defer { invokedSomeOptionalClosureOpaqueReturnTypeExpectation.fulfill() }
        invokedSomeOptionalClosureOpaqueReturnTypeCount += 1
        if shouldInvokeSomeOptionalClosureOpaqueReturnTypeCompletion {
            _ = completion?()
        }
    }

    internal var invokedSomeOptionalClosureOptionalOpaqueParameter: Bool { invokedSomeOptionalClosureOptionalOpaqueParameterCount > 0 }
    internal var invokedSomeOptionalClosureOptionalOpaqueParameterCount = 0
    internal var stubbedSomeOptionalClosureOptionalOpaqueParameterCompletionResult: ((any OpaqueType)?, Void)?
    internal var invokedSomeOptionalClosureOptionalOpaqueParameterExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func someOptionalClosureOptionalOpaqueParameter(completion: (((any OpaqueType)?) -> Void)?) {
        defer { invokedSomeOptionalClosureOptionalOpaqueParameterExpectation.fulfill() }
        invokedSomeOptionalClosureOptionalOpaqueParameterCount += 1
        if let result = stubbedSomeOptionalClosureOptionalOpaqueParameterCompletionResult {
            completion?(result.0)
        }
    }

    internal var invokedSomeOptionalClosureOptionalOpaqueReturnType: Bool { invokedSomeOptionalClosureOptionalOpaqueReturnTypeCount > 0 }
    internal var invokedSomeOptionalClosureOptionalOpaqueReturnTypeCount = 0
    internal var shouldInvokeSomeOptionalClosureOptionalOpaqueReturnTypeCompletion = false
    internal var invokedSomeOptionalClosureOptionalOpaqueReturnTypeExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func someOptionalClosureOptionalOpaqueReturnType(completion: (() -> (any OpaqueType)?)?) {
        defer { invokedSomeOptionalClosureOptionalOpaqueReturnTypeExpectation.fulfill() }
        invokedSomeOptionalClosureOptionalOpaqueReturnTypeCount += 1
        if shouldInvokeSomeOptionalClosureOptionalOpaqueReturnTypeCompletion {
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

internal class DefaultParameterNamingsMock: ParameterNamings {

    internal init() { }

    internal var invokedAnonymousClosureParameterName: Bool { invokedAnonymousClosureParameterNameCount > 0 }
    internal var invokedAnonymousClosureParameterNameCount = 0
    internal var stubbedAnonymousClosureParameterNameClosureResult: String?
    internal var invokedAnonymousClosureParameterNameExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func anonymousClosureParameterName(closure: (String) -> String) {
        defer { invokedAnonymousClosureParameterNameExpectation.fulfill() }
        invokedAnonymousClosureParameterNameCount += 1
        if let result = stubbedAnonymousClosureParameterNameClosureResult {
            _ = closure(result)
        }
    }

    internal var invokedAnonymousClosurename: Bool { invokedAnonymousClosurenameCount > 0 }
    internal var invokedAnonymousClosurenameCount = 0
    internal var stubbedAnonymousClosurenameInternalNameResult: String?
    internal var invokedAnonymousClosurenameExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func anonymousClosurename(_ internalName: (String) -> String) {
        defer { invokedAnonymousClosurenameExpectation.fulfill() }
        invokedAnonymousClosurenameCount += 1
        if let result = stubbedAnonymousClosurenameInternalNameResult {
            _ = internalName(result)
        }
    }

    internal var invokedAnonymousName: Bool { invokedAnonymousNameCount > 0 }
    internal var invokedAnonymousNameCount = 0
    internal var invokedAnonymousNameParameters: (internalName: String, Void)?
    internal var invokedAnonymousNameParametersList: [(internalName: String, Void)] = []
    internal var invokedAnonymousNameExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func anonymousName(_ internalName: String) {
        defer { invokedAnonymousNameExpectation.fulfill() }
        invokedAnonymousNameCount += 1
        invokedAnonymousNameParameters = (internalName: internalName, ())
        invokedAnonymousNameParametersList.append((internalName: internalName, ()))
    }

    internal var invokedExternalClosurename: Bool { invokedExternalClosurenameCount > 0 }
    internal var invokedExternalClosurenameCount = 0
    internal var stubbedExternalClosurenameInternalNameResult: String?
    internal var invokedExternalClosurenameExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func externalClosurename(externalName internalName: (String) -> String) {
        defer { invokedExternalClosurenameExpectation.fulfill() }
        invokedExternalClosurenameCount += 1
        if let result = stubbedExternalClosurenameInternalNameResult {
            _ = internalName(result)
        }
    }

    internal var invokedExternalName: Bool { invokedExternalNameCount > 0 }
    internal var invokedExternalNameCount = 0
    internal var invokedExternalNameParameters: (internalName: String, Void)?
    internal var invokedExternalNameParametersList: [(internalName: String, Void)] = []
    internal var invokedExternalNameExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func externalName(externalName internalName: String) {
        defer { invokedExternalNameExpectation.fulfill() }
        invokedExternalNameCount += 1
        invokedExternalNameParameters = (internalName: internalName, ())
        invokedExternalNameParametersList.append((internalName: internalName, ()))
    }

    internal var invokedInternalClosurename: Bool { invokedInternalClosurenameCount > 0 }
    internal var invokedInternalClosurenameCount = 0
    internal var stubbedInternalClosurenameInternalNameResult: String?
    internal var invokedInternalClosurenameExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func internalClosurename(internalName: (String) -> String) {
        defer { invokedInternalClosurenameExpectation.fulfill() }
        invokedInternalClosurenameCount += 1
        if let result = stubbedInternalClosurenameInternalNameResult {
            _ = internalName(result)
        }
    }

    internal var invokedInternalName: Bool { invokedInternalNameCount > 0 }
    internal var invokedInternalNameCount = 0
    internal var invokedInternalNameParameters: (internalName: String, Void)?
    internal var invokedInternalNameParametersList: [(internalName: String, Void)] = []
    internal var invokedInternalNameExpectation = XCTestExpectation(description: "\(#function) expectation")

    internal func internalName(internalName: String) {
        defer { invokedInternalNameExpectation.fulfill() }
        invokedInternalNameCount += 1
        invokedInternalNameParameters = (internalName: internalName, ())
        invokedInternalNameParametersList.append((internalName: internalName, ()))
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
