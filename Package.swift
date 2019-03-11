// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftGraphviz",
    products: [
        .library(
            name: "SwiftGraphviz",
            targets: ["SwiftGraphviz"]),
    ],
    targets: [
        .target(
            name: "SwiftGraphviz",
            dependencies: []),
        .testTarget(
            name: "SwiftGraphvizTests",
            dependencies: ["SwiftGraphviz"]),
    ]
)
