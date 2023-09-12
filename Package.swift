// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SourceryTemplates",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "MockDeclarations", targets: [
            "MockDeclarations",
        ])
    ],
    dependencies: [
        .package(url: "https://github.com/krzysztofzablocki/Sourcery", exact: "2.0.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Templates",
            dependencies: [
                .product(name: "SourceryRuntime", package: "Sourcery"),
            ],
            exclude: [
                "AutoMockable.swifttemplate",
                "AutoStubbable.swifttemplate",
            ]
        ),
        .target(
            name: "MockDeclarations",
            dependencies: [
                "NestedMockDeclarations",
            ]
        ),
        .target(
            name: "NestedMockDeclarations"
        ),
        .testTarget(
            name: "TemplateTests",
            dependencies: [
                "MockDeclarations",
            ]
        ),
    ]
)
