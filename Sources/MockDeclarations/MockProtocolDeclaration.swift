// sourcery: AutoMockable
protocol MockProtocolDeclaration {
    var immutableProperty: Int { get }
    var mutableProperty: Int { get set }
    var immutableOptionalProperty: Int? { get }
    var mutableOptionalProperty: Int? {get set }

    func method(property: Int, optionalProperty: Int?, closureProperty: @escaping (Bool, Int) -> Int) -> Int
    func anotherMethod()
    func anotherMethod(with input: String)
}
