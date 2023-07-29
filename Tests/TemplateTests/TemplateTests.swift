import XCTest

final class TemplateTests: XCTestCase {

    var sut: DefaultMockProtocolDeclarationMock!

    override func setUp() {
        super.setUp()
        sut = makeSUT()
    }

    func makeSUT() -> DefaultMockProtocolDeclarationMock {
        DefaultMockProtocolDeclarationMock()
    }

    func test_immutablePropertyGet() {
        // When
        sut.stubbedImmutableProperty = 1

        // Then
        XCTAssertEqual(sut.immutableProperty, 1)
        XCTAssertEqual(sut.invokedImmutablePropertyGetterCount, 1)
        XCTAssertTrue(sut.invokedImmutablePropertyGetter)
    }

    func test_mutablePropertyGet() {
        // When
        sut.stubbedMutableProperty = 1

        // Then
        XCTAssertEqual(sut.mutableProperty, 1)
        XCTAssertEqual(sut.invokedMutablePropertyGetterCount, 1)
        XCTAssertTrue(sut.invokedMutablePropertyGetter)
    }

    func test_mutablePropertySet() {
        // When
        sut.mutableProperty = 2
        sut.mutableProperty = 1

        // Then
        XCTAssertEqual(sut.invokedMutableProperty, 1)
        XCTAssertEqual(sut.invokedMutablePropertyList, [2, 1])
        XCTAssertEqual(sut.invokedMutablePropertySetterCount, 2)
        XCTAssertTrue(sut.invokedMutablePropertySetter)
    }
}
