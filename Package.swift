// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "collections",
    products: [
        .library(
            name: "Collections",
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
