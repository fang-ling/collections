// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "XHL",
    products: [
        .library(
            name: "XHL",
            targets: ["XHL"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "XHL",
            dependencies: []),
        .testTarget(
            name: "XHLTests",
            dependencies: ["XHL"]),
    ]
)
