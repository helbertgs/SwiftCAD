// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftCAD",
    products: [
        .library(
            name: "SwiftCAD",
            targets: ["SwiftCAD"]),
        .library(
            name: "Spatial",
            targets: ["Spatial"]),
        .executable(
            name: "Sample",
            targets: ["Sample"]),
    ],
    targets: [
        .target(
            name: "Spatial"),
        .target(
            name: "SwiftCAD",
            dependencies: [ "Spatial" ] 
        ),
        .executableTarget(
            name: "Sample", 
            dependencies: ["SwiftCAD"]
        ),
        .testTarget(
            name: "SwiftCADTests",
            dependencies: ["SwiftCAD"]
        ),
    ]
)
