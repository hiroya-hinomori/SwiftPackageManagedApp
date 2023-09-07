// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Sandbox",
    platforms: [
      .iOS(.v16),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "App",
            targets: ["App"]),
        .library(
            name: "API",
            targets: ["API"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/ishkawa/APIKit.git", from: "5.4.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "App",
            dependencies: [
                "API",
            ]),
        .testTarget(
            name: "AppTests",
            dependencies: ["App"]),
        .target(
            name: "API",
            dependencies: [
                .product(name: "APIKit", package: "APIKit"),
            ]),
        .testTarget(
            name: "APITests",
            dependencies: ["API"]),
    ]
)
