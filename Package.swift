// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppPricingSDK",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AppPricingSDK",
            targets: ["AppPricingSDK"]),
    ],
    dependencies: [.package(url: "https://github.com/evgenyneu/keychain-swift.git",
                            from: "24.0.0")],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AppPricingSDK",
            dependencies: [.product(name: "KeychainSwift", package: "keychain-swift")]),
        .testTarget(
            name: "AppPricingSDKTests",
            dependencies: ["AppPricingSDK"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
