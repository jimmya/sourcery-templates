import Foundation

// sourcery: AutoMockable
protocol MockProtocolWithProperties {
    var immutableProperty: Int { get }
    var mutableProperty: Int { get set }
    var immutableOptionalProperty: Int? { get }
    var mutableOptionalProperty: Int? { get set }
}

// sourcery: AutoMockable
protocol MockProtocolWithMultipleMethods {
    func anotherMethod()
    func anotherMethod(with input: String) async throws
}

// sourcery: AutoMockable
protocol MockProtocolWithClosureMethod {
    func method(closureProperty: @escaping (Bool, Int) -> Int)
}

// sourcery: AutoMockable
protocol MockProtocolWithOptionalClosureMethod {
    func method(closureProperty: ((Bool, Int) -> Int)?)
}

// sourcery: AutoMockable
protocol MockProtocolWithPropertyAndMethod {
    var property: String { get }
    
    func method()
}

// sourcery: AutoMockable
protocol MockProtocolWithReturnSelf {
    func method() -> Self
}

class SomeType { }

// sourcery: AutoMockable
public protocol MockProtocolWithPublicAccessLevel {
    func method()
}

// sourcery: AutoMockable
protocol MockProtocolWithGenericInheritanceDeclaration where Self: SomeType {
    init(someParameter: Int)
    init?(someFailableParameter: Int)
    
    func method()
}

// sourcery: AutoMockable
protocol MockProtocolWithOpaqueTypes {
    
    var immutableOpaqueObject: any OpaqueType { get }
    var immutableOptionalOpaqueObject: (any OpaqueType)? { get }
    var immutableOpaqueClosureParameter: (any OpaqueType) -> Void { get }
    var immutableOptionalOpaqueClosureParameter: ((any OpaqueType)?) -> Void { get }

    var immutableClosureOpaqueReturnType: () -> any OpaqueType { get }
    var immutableClosureOptionalOpaqueReturnType: () -> (any OpaqueType)? { get }
    var immutableOptionalClosureOpaqueParameter: ((any OpaqueType) -> Void)? { get }
    var immutableOptionalClosureOptionalOpaqueParameter: (((any OpaqueType)?) -> Void)? { get }
    var immutableOptionalClosureOpaqueReturnType: (() -> any OpaqueType)? { get }
    var immutableOptionalClosureOpationalOpaqueReturnType: (() -> (any OpaqueType)?)? { get }

    var mutableOpaqueObject: any OpaqueType { get set }
    var mutableOptionalOpaqueObject: (any OpaqueType)? { get set }
    var mutableClosureOpaqueParameter: (any OpaqueType) -> Void { get set }
    var mutableClosureOptionalOpaqueParameter: ((any OpaqueType)?) -> Void { get set }
    var mutableOptionalClosureOpaqueParameter: ((any OpaqueType) -> Void)? { get set }
    var mutableOptionalClosureOptionalOpaqueParameter: (((any OpaqueType)?) -> Void)? { get set }
    var mutableOptionalClosureOpaqueReturnType: (() -> any OpaqueType)? { get set }
    var mutableOptionalClosureOptionalOpaqueReturnType: (() -> (any OpaqueType)?)? { get set }

    func someOpaqueReturningFunction() -> any OpaqueType
    func someOptionalOpaqueReturningFunction() -> (any OpaqueType)?
    func someOpaqueParameterFunction(opaqueObject: any OpaqueType)
    func someOptionalOpaqueParameterFunction(opaqueObject: (any OpaqueType)?)
    func someClosureOpaqueParameter(completion: (any OpaqueType) -> Void)
    func someClosureOptionalOpaqueParameter(completion: ((any OpaqueType)?) -> Void)
    func someOptionalClosureOpaqueParameter(completion: ((any OpaqueType) -> Void)?)
    func someOptionalClosureOptionalOpaqueParameter(completion: (((any OpaqueType)?) -> Void)?)

    func someClosureOpaqueReturnType(completion: () -> any OpaqueType)
    func someClosureOptionalOpaqueReturnType(completion: () -> (any OpaqueType)?)
    func someOptionalClosureOpaqueReturnType(completion: (() -> any OpaqueType)?)
    func someOptionalClosureOptionalOpaqueReturnType(completion: (() -> (any OpaqueType)?)?)

    func methodWithGenericConstraint<T: Equatable>(property: SomeGenericStruct<T>, values: Set<String>) -> T
}

struct SomeGenericStruct<T> {

}

// sourcery: AutoMockable
protocol ParameterNamings {

    func internalName(internalName: String)
    func externalName(externalName internalName: String)
    func anonymousName(_ internalName: String)
    func internalClosurename(internalName: (String) -> String)
    func externalClosurename(externalName internalName: (String) -> String)
    func anonymousClosurename(_ internalName: (String) -> String)
    func anonymousClosureParameterName(closure: (_: String) -> String)
}

// sourcery: AutoMockable
protocol MockProtocolWithGenericFunction {
    func doSomething<T>(parameter: T, anotherParameter: Int)
}

// sourcery: AutoMockable
protocol URLSessionLogic {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

// sourcery: AutoMockable
protocol BasicRequestExecutorLogic {

    /// Execute a `URLRequest` and ignore the response
    /// - Parameter urlRequest: The `URLRequest` to execute
    func execute(_ urlRequest: URLRequest) async throws

    /// Execute a `URLRequest` and JSON decode the response into the generic response type using the
    /// `JSONDecoder.polarsteps()` JSON decoder.
    /// - Parameters:
    ///   - urlRequest: The `URLRequest` to execute
    /// - Returns: The JSON decoded response object with the generic response type
    func execute<Response>(_ urlRequest: URLRequest) async throws -> Response where Response: Decodable

    /// Execute a `URLRequest` and JSON decode the response into the generic response type
    /// - Parameters:
    ///   - urlRequest: The `URLRequest` to execute
    ///   - decoder: The `JSONDecoder` to use for decoding the response object
    /// - Returns: The JSON decoded response object with the generic response type
    func execute<Response>(_ urlRequest: URLRequest, decoder: JSONDecoder) async throws -> Response where Response: Decodable
}
