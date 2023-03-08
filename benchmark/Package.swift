// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "benchmark",
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections-benchmark",
                 from: "0.0.3"),
        .package(url: "https://github.com/fang-ling/swift-c-collections",
                 from: "0.0.3")
    ],
    targets: [
        .executableTarget(
            name: "benchmark",
            dependencies: [
                .product(name: "CollectionsBenchmark",
                         package: "swift-collections-benchmark"),
                .product(name: "CCollections", package: "swift-c-collections")
            ]),
        .testTarget(
            name: "benchmarkTests",
            dependencies: ["benchmark"]),
    ]
)
