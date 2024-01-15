// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MVVMI",
    platforms: [.iOS(.v14), .macOS(.v12)],
    products: [
        .library(
            name: "MVVMI",
            targets: ["MVVMI"]),
    ],
    targets: [
        .target(
            name: "MVVMI"),
        .testTarget(
            name: "MVVMITests",
            dependencies: ["MVVMI"]),
    ]
)
