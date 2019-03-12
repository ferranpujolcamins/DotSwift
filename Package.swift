// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftGraphviz",
    products: [
        .library(
            name: "SwiftGraphvizAttributes",
            targets: ["SwiftGraphvizAttributes"]),
        .library(
            name: "SwiftGraphvizEncoder",
            targets: ["SwiftGraphvizEncoder"]),
    ],
    dependencies: [
        .package(url: "https://github.com/davecom/SwiftGraph", .branch("release2.1/swift5"))
    ],
    targets: [
        .target(
            name: "SwiftGraphvizAttributes",
            dependencies: []),
        .testTarget(
            name: "SwiftGraphvizAttributesTests",
            dependencies: ["SwiftGraphvizAttributes"]),

        .target(
            name: "SwiftGraphvizEncoder",
            dependencies: ["SwiftGraphvizAttributes", "SwiftGraph"]),
        .testTarget(
            name: "SwiftGraphvizEncoderTests",
            dependencies: ["SwiftGraphvizEncoder"]),
    ]
)
