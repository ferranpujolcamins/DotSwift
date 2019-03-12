// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftGraphviz",
    products: [
        .library(
            name: "SwiftGraphvizAttributes",
            targets: ["SwiftGraphvizAttributes"]
        ),
        .library(
            name: "SwiftGraphvizEncoder",
            targets: ["SwiftGraphvizEncoder"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftGraphvizAttributes",
            dependencies: [],
            path: "SwiftGraphvizAttributes/Sources"
        ),
        .testTarget(
            name: "SwiftGraphvizAttributesTests",
            dependencies: ["SwiftGraphvizAttributes"],
            path: "SwiftGraphvizAttributes/Tests"
        ),

        .target(
            name: "SwiftGraphvizEncoder",
            dependencies: ["SwiftGraphvizAttributes"],
            path: "SwiftGraphvizEncoder/Sources"
        ),
        .testTarget(
            name: "SwiftGraphvizEncoderTests",
            dependencies: ["SwiftGraphvizEncoder"],
            path: "SwiftGraphvizEncoder/Tests"
        ),
    ]
)
