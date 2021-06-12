// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UI",
    platforms: [.iOS(.v14), .macOS(.v11), .tvOS(.v14)],
    products: [
        .library(
            name: "UI",
            targets: ["UI"]),
    ],
    dependencies: [
      .package(name: "Backend", path: "./Backend"),
    ],
    targets: [
        .target(
            name: "UI",
            dependencies: ["Backend"]),
        .testTarget(
            name: "UITests",
            dependencies: ["UI"]),
    ]
)
