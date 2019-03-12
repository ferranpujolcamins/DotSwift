// swift-tools-version:4.0
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
            dependencies: ["SwiftGraphvizAttributes"]),
        .testTarget(
            name: "SwiftGraphvizEncoderTests",
            dependencies: ["SwiftGraphvizEncoder"]),
    ]
)
