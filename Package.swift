// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DotSwift",
    products: [
        .library(
            name: "DotSwiftAttributes",
            targets: ["DotSwiftAttributes"]
        ),
        .library(
            name: "DotSwiftEncoder",
            targets: ["DotSwiftEncoder"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "DotSwiftAttributes",
            dependencies: [],
            path: "DotSwiftAttributes/Sources"
        ),
        .testTarget(
            name: "DotSwiftAttributesTests",
            dependencies: ["DotSwiftAttributes"],
            path: "DotSwiftAttributes/Tests"
        ),

        .target(
            name: "DotSwiftEncoder",
            dependencies: ["DotSwiftAttributes"],
            path: "DotSwiftEncoder/Sources"
        ),
        .testTarget(
            name: "DotSwiftEncoderTests",
            dependencies: ["DotSwiftEncoder"],
            path: "DotSwiftEncoder/Tests"
        ),
    ]
)
