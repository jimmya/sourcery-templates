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

class SomeType { }

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
    var mutableOpaqueObject: any OpaqueType { get set }
    var mutableOptionalOpaqueObject: (any OpaqueType)? { get set }

    func someOpaqueReturningFunction() -> any OpaqueType
    func someOptionalOpaqueReturningFunction() -> (any OpaqueType)?
    func someOpaqueParameterFunction(opaqueObject: any OpaqueType)
    func someOptionalOpaqueParameterFunction(opaqueObject: (any OpaqueType)?)
}
