// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "xhl",
    products: [
        .library(
            name: "xhl",
            targets: ["xhl"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "xhl",
            dependencies: []),
        .testTarget(
            name: "xhlTests",
            dependencies: ["xhl"]),
    ]
)
