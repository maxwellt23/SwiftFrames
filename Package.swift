// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftFrames",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftFrames",
            targets: ["SwiftFrames"]),
        .executable(name: "SwiftFramesDemo", targets: ["SwiftFramesDemo"])
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftFrames"),
        .executableTarget(name: "SwiftFramesDemo", dependencies: ["SwiftFrames"]),
        .testTarget(
            name: "SwiftFramesTests",
            dependencies: ["SwiftFrames"]
        ),
    ]
)
