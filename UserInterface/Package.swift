// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UserInterface",
    platforms: [
        .macOS(.v12),
        .macCatalyst(.v15),
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "UserInterface",
            targets: ["UserInterface"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/sindresorhus/Preferences", branch: "main"),
        .package(url: "https://github.com/sindresorhus/Defaults.git", branch: "main"),
        .package(url: "https://github.com/kean/Get.git", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "UserInterface",
            dependencies: ["Preferences", "Defaults", "Get"],
            path: "Sources/UserInterface"
        ),
        .testTarget(
            name: "UserInterfaceTests",
            dependencies: ["UserInterface"]),
    ]
)
