- [Introduction](#introduction)
- [Installation](#installation)
  - [Prerequisites](#prerequisites)
- [Configuration](#configuration)
  - [Running sourcery](#running-sourcery)
- [Unit testing templates](#unit-testing-templates)
  - [Protocol mocks](#protocol-mocks)
  - [Model stubs](#model-stubs)
- [Dependency container templates](#dependency-container-templates)
  - [Usage](#usage)
  - [Mock container](#mock-container)

# Introduction

This repository contains various templates to be used with [Sourcery](https://github.com/krzysztofzablocki/Sourcery). These templates will help greatly to reduce time writing implementations for testing purposes, time you can better spend on features or tech debt.

> But Sourcery already has its own Mockable template.

That's correct, but that template is quite limited. It doesn't support concurrency very well, for example.

# Installation

## Prerequisites

- Sourcery should be installed
- See: https://github.com/krzysztofzablocki/Sourcery?tab=readme-ov-file#installation

For now the easiest way is to add this repository as a [submodule](https://git-scm.com/book/en/v2/Git-Tools-Submodules).
To use it in your `.sourcery.yml` config files simply add a path to the `Sources/Templates` directory (or directly `Sources/Templates/AutoMockable.swifttemplate`/`Sources/Templates/AutoStubbable.swifttemplate` if you only intend to use one).

```yaml
templates:
  - SourceryTemplatesCheckoutDirectory/Sources/Templates/AutoMockable.swifttemplate
```

> Why a submodule? There's other packages using these awesome Swift Macros for this, that's much easier.

While Swift Macros are indeed awesome, they have a few drawbacks.

1. They take relatively long to compile
2. Testing code can get mixed into your production code
   - Unless you create another way to properly split it.

This repository has to be added as a git submodule so it is possible to read the `.swifttemplate` files. That's not possible when added as SPM or in a different way.

# Configuration

A configuration should be created in a `.sourcery.yml` file. It is also possible to name it differently.

Configurations should live in the project root, so all files can be analyzed.

Example configuration for generating mocks:

```yaml
configurations:
  - package:
      - path: TestPackage
        target: TestPackage
    templates:
      - <submodule location>/Sources/Templates/AutoMockable.swifttemplate
    output: Mocks/Generated/Mocks.generated.swift
    args:
      imports:
        - XCTest
        - Foundation
        - Combine
      testableImports:
        - OtherPackage
      mockPrefix: Prefix # Optional. Default naming is `Custom<Protocol>Mock
      mockSuffix: Suffix # Optional. Default naming is `Custom<Protocol>Mock
```

This configuration will:

- Analyze the target named `TestPackage` within the `TestPackage` package
- It will use the `AutoMockable.swifttemplate` template and output the result in `Mocks.generated.swift` file
- In this output file `XCTest`, `Foundation` and `Combine` will be imported
- In this output file `OtherPackage` will be `@testable` imported
- Mocks will be named `Prefix<Protocol>Suffix`

> [!IMPORTANT]
>
> Protocols have to be annotated with `// sourcery: AutoMockable` to be used with the templates

## Running sourcery

Running `$ sourcery` will analyze to project and use the configuration you created in `.sourcery.yml` and output the result in your defined output file.

If you named the configuration differently you have to run

`$ sourcery --config .<config name>.yml`

# Unit testing templates

There are two templates to help write code you don't want to spend time on writing yourself. One for creating protocols mocks and one for creating models stubs, both used for testing purposes.

## Protocol mocks

Template used:

- AutoMockable.swifttemplate

This template generates mock definitions for any protocol that has the `// sourcery: AutoMockable` annotation. It will create definitions for all properties and methods in the main definition of the protocol (extensions are excluded).

**Definition:**

```swift
// sourcery: AutoMockable
protocol ProtocolDeclaration {
    var immutableProperty: Int { get }
    var mutableProperty: Int { get set }

    func method(property: Int) -> Int
}

```

**Generated mock:**

```swift
class DefaultMockProtocolDeclarationMock: ProtocolDeclaration {

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

## Model stubs

Template used:

- AutoStubbable.swifttemplate

> [!IMPORTANT]
>
> Models have to be annotated with `// sourcery: AutoStubbable` to be analyzed by Sourcery

This template generates stub methods for all your models. It will attempt to default any property to make initialisation easy. This way you can focus on initialising what matters in your test.

If you have models with a lot of properties, this is an ideal way to handle those models in testing scenarios

**Definition:**

```swift
// sourcery: AutoStubbable
struct DomainModelDeclaration {
    let integer: Int
    let optionalProperty: String?
}

```

**Generated stub**:

```swift
internal extension DomainModelDeclaration {
    static func stub(
        integer: Int = 0,
        optionalProperty: String? = nil
    ) -> MockDomainModelDeclaration {
        MockDomainModelDeclaration(
            integer: integer,
            optionalProperty: optionalProperty
        )
    }
}
```

**Usage**:

```swift
class TestClass: XCTestCase {

    func testCase() {
        // This will create a model with the default values declared in `.stub()` extension
        let stubModel1 = DomainModelDeclaration.stub()
        XCTAssertEqual(stubModel2.integer, 0) // True
        XCTAssertEqual(stubModel2.optionalProperty, nil) // True

        // This will create a model with the default values declared in `.stub()` extension, but will override only the `integer` property
        let stubModel2 = DomainModelDeclaration.stub(integer: 10)
        XCTAssertEqual(stubModel2.integer, 10) // True
        XCTAssertEqual(stubModel2.optionalProperty, nil) // True

        // This will create a model with all properties overridden
        let stubModel3 = DomainModelDeclaration.stub(
            integer: 10,
            optionalProperty: "Test"
        )

        XCTAssertEqual(stubModel3.integer, 10) // True
        XCTAssertEqual(stubModel3.optionalProperty, "Test") // True
    }
}
```

# Dependency container templates

As a bonus, it is possible to generate a dependency container using these templates, also greatly reducing time writing and maintaining code.

Templates used:

- AutoRegistering.swifttemplate
- AutoRegisterable.swifttemplate

> [!IMPORTANT]
>
> The package [Factory](https://github.com/hmlongco/Factory) is used to handle dependencies. This package has to be added to your project to make use of these templates.

Configuring a dependency container contains of two steps:

1. Defining the dependency
2. Registering the dependency

## Usage

**Configuration**

```yaml
configurations:
  # 1. Defining dependencies
  - package:
      - path: APackage
        target: ATarget
    templates:
      - <submodule path>/Sources/Templates/AutoRegisterable.swifttemplate
    output: Container/ATargetRegisterable.generated.swift
    args:
      containerName: AContainer
      propertyWrapperName: AContainerWrapper
      imports: [Factory]

    # 2. Registering dependencies
    - package:
      - path: APackage
        target: ATarget
    templates:
      - <submodule path>/Sources/Templates/AutoRegistering.swifttemplate
    output: Container/ATargetRegistering.generated.swift
    args:
      containerName: AContainer # This `containerName` should match the `AutoRegisterable` `containerName`
      imports: [Factory]
```

**Usage**

> [!IMPORTANT]
>
> Any `class` or `struct` you want to register in the container has to be annotated with `// sourcery: AutoRegister` and conform to a `protocol`.

```swift
protocol ADependencyProtocol { }

// sourcery: AutoRegister
struct ADependency: ADependencyProtocol {

}
```

**Generated code**

1. Defining the dependencies

```swift
public final class AContainer: SharedContainer {
    public static var shared = AContainer()
    public var manager = ContainerManager()
}

extension AContainer {

    public var aDependency: Factory<ADependencyProtocol> {
        self { fatalError("ADependencyProtocol not registered") }
    }
}

@propertyWrapper public struct AContainerWrapper<T> {
    public static func make(_ keyPath: KeyPath<AContainer, Factory<T>>) -> T {
        AContainer.shared[keyPath: keyPath].resolve()
    }

    private var injected: Injected<T>

    public init(_ keyPath: KeyPath<AContainer, Factory<T>>) {
        self.injected = .init(keyPath)
    }

    /// Manages the wrapped dependency.
    public var wrappedValue: T {
        get { return injected.wrappedValue }
        mutating set { injected.wrappedValue = newValue }
    }

    /// Unwraps the property wrapper granting access to the resolve/reset function.
    public var projectedValue: Injected<T> {
        get { return injected.projectedValue }
        mutating set { injected.projectedValue = newValue }
    }

    /// Grants access to the internal Factory.
    public var factory: Factory<T> {
        injected.factory
    }

    /// Allows the user to force a Factory resolution at their discretion.
    public mutating func resolve(reset options: FactoryResetOptions = .none) {
        injected.resolve(reset: options)
    }
}

extension UseCase: @unchecked Sendable where T: Sendable { }

// swiftlint:enable all
```

2. Registering the dependencies

```swift
extension AContainer: AutoRegistering {
    public func autoRegister() {
        aDependency.register { ADependency() }
    }
}
```

**Usage**

```swift
class AClass {

    @AContainerWrapper(\.aDependency) private var aDependency

}
```

By separating the definition and the registration of the dependencies makes it really flexible. This way it is possible to define the dependencies in one package, and register the implementations in a different package.

## Mock container
