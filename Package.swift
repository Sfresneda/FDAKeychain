// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FDAKeychain",
    platforms: [
        .macOS(.v11),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "FDAKeychain",
            targets: ["FDAKeychain"]),
    ],
    targets: [
        .target(
            name: "FDAKeychain"),
        .testTarget(
            name: "FDAKeychainTests",
            dependencies: ["FDAKeychain"]),
    ]
)
