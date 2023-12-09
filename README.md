# Sourcery Templates
This repository contains 2 [Sourcery](https://github.com/krzysztofzablocki/Sourcery) templates which you can use in your projects: `AutoMockable` and `AutoStubbable`

## Installation
For now the easiest way is to add this repository as a [submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules).
To use it in your `.sourcery.yml` config files simply add a path to the `Sources/Templates` directory (or directly `Sources/Templates/AutoMockable.swifttemplate`/`Sources/Templates/AutoStubbable.swifttemplate` if you only intend to use one).
```yaml
templates:
    - SourceryTemplatesCheckoutDirectory/Sources/Templates/AutoMockable.swifttemplate
```
## AutoMockable.swifttemplate
This template generates mock definions for any protocol that has the `// sourcery: AutoMockable` annotation. It will create definitions for all properties and methods in the main definition of the protocol (extensions are excluded).

**Definition:**
```swift
// sourcery: AutoMockable
protocol MockProtocolDeclaration {
    var immutableProperty: Int { get }
    var mutableProperty: Int { get set }

    func method(property: Int) -> Int
}

```
**Generated mock:**
```swift
class DefaultMockProtocolDeclarationMock: MockProtocolDeclaration {

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

    var invokedMethod = false
    var invokedMethodCount = 0
    var invokedMethodParameters: (property: Int, Void)?
    var invokedMethodParametersList: [(property: Int, Void)] = []
    var stubbedMethodResult: Int! = 0
    var invokedMethodExpectation = XCTestExpectation(description: "\(#function) expectation")

    func method(property: Int) -> Int {
        defer { invokedMethodExpectation.fulfill() }
        invokedMethod = true
        invokedMethodCount += 1
        invokedMethodParameters = (property: property, ())
        invokedMethodParametersList.append((property: property, ()))
        return stubbedMethodResult
    }
}
```

## Arguments
Add the following arguments to your `.sourcery.yml` file to provide any required imports for the generated file.
```yaml
args:
  imports: [Foundation, XCTest]
  testableImports: [ModuleContainingYourProtocol]
```
To customize the naming of the class mock generation you can add a `prefix` and/or `suffix` argument.
If _BOTH_ are not provided, `Default` will be used as `prefix` and `Mock` will be used as suffix.`

Example:

```yaml
args:
  mockPrefix: "Apple"
  mockSuffix: "Pear"
```

```swift
// sourcery: AutoMockable
protocol ExampleProtocol { }

// Generated
class AppleExampleProtocolPear: ExampleProtocol {

}
```

After generating you can use the mock definitions to easily setup your tests, provide input and assert.

## AutoStubbable.swifttemplate
This template generates stub methods for all your models. It'll attempt to default any property to make initialisation easy. This way you can focus on initialising what matters in your test.

**Definition:**
```swift
// sourcery: AutoStubbable
struct MockDomainModelDeclaration {
    let property: Int
    let optionalProperty: String?
}

```
**Generated stub**:
```swift
internal extension MockDomainModelDeclaration {
    static func stub(
        property: Int = 0,
        optionalProperty: String? = nil
    ) -> MockDomainModelDeclaration {
        MockDomainModelDeclaration(
            property: property,
            optionalProperty: optionalProperty
        )
    }
}
```
