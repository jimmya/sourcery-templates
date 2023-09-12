import Foundation

// sourcery: AutoMockable
protocol MockProtocolWithProperties {
    var immutableProperty: Int { get }
    var mutableProperty: Int { get set }
    var immutableOptionalProperty: Int? { get }
    var mutableOptionalProperty: Int? {get set }
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
