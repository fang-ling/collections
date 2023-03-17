// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Benchmarks",
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections-benchmark",
                 from: "0.0.3"),
        .package(url: "https://github.com/apple/swift-collections",
                 branch: "release/1.1"),
        .package(url: "https://github.com/fang-ling/c-collections",
                 branch: "move-to-swift")
    ],
    targets: [
        .executableTarget(
            name: "Benchmarks",
            dependencies: [
                .product(name: "CollectionsBenchmark",
                         package: "swift-collections-benchmark"),
                .product(name: "Collections",
                         package: "swift-collections",
                         moduleAliases: ["Collections" : "SCollections"]),
                .product(name: "collections",
                         package: "c-collections"/*,
                         moduleAliases: ["collections" : "XHL"]*/)
            ]),
        .testTarget(
            name: "BenchmarksTests",
            dependencies: ["Benchmarks"]),
    ]
)
