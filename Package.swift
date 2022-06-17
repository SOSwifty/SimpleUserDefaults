// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SimpleUserDefaults",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "SimpleUserDefaults",
            targets: ["SimpleUserDefaults"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SimpleUserDefaults",
            dependencies: []),
        .testTarget(
            name: "SimpleUserDefaultsTests",
            dependencies: ["SimpleUserDefaults"]),
    ]
)
