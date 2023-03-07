// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "benchmark",
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections-benchmark",
                 from: "0.0.3"),
    ],
    targets: [
        .executableTarget(
            name: "benchmark",
            dependencies: [
                .product(name: "CollectionsBenchmark",
                         package: "swift-collections-benchmark"),
            ]),
        .testTarget(
            name: "benchmarkTests",
            dependencies: ["benchmark"]),
    ]
)
