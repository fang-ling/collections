// swift-tools-version: 5.7

import PackageDescription

let package = Package(
  name: "xhl",
  products: [
    .library(
      name: "Collections", targets: ["Collections"]
    ),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "Collections",
      dependencies: []),
    .testTarget(
      name: "CollectionsTests",
      dependencies: ["Collections"]),
  ]
)
