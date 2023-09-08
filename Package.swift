// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Sandbox",
    platforms: [
      .iOS(.v16),
    ],
    products: [
        .library(
            name: "App",
            targets: ["App"]),
        .library(
            name: "API",
            targets: ["API"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ishkawa/APIKit.git", from: "5.4.0"),
    ],
    targets: [
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
