// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "XHL",
    products: [
        .library(
            name: "XHL",
            targets: ["collections"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "collections",
            dependencies: []),
        .testTarget(
            name: "collectionsTests",
            dependencies: ["collections"]),
    ]
)
