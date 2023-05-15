// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Benchmarks",
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections-benchmark",
                 from: "0.0.3"),
        .package(url: "https://github.com/apple/swift-collections",
                 branch: "release/1.1"),
        .package(url: "https://github.com/fang-ling/collections",
                 from: "0.0.1-beta.3")
    ],
    targets: [
        .executableTarget(
            name: "Benchmarks",
            dependencies: [
                .product(name: "CollectionsBenchmark",
                         package: "swift-collections-benchmark"),
                .product(name: "Collections",
                         package: "swift-collections"),
                .product(name: "xhl",
                         package: "collections")
            ]),
        .testTarget(
            name: "BenchmarksTests",
            dependencies: ["Benchmarks"]),
    ]
)
