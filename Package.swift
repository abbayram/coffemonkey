import PackageDescription

let package = Package(
    name: "coffemonkey",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "coffemonkey",
            targets: ["coffemonkey"]),
    ],
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "8.0.0"),
        .package(url: "https://github.com/apple/swift-package-manager.git", from: "0.5.0")
    ],
    targets: [
        .target(
            name: "coffemonkey",
            dependencies: [
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
                "LogoAnimationView",
                .product(name: "PackageDescription", package: "swift-package-manager")
            ]),
        .testTarget(
            name: "coffemonkeyTests",
            dependencies: ["coffemonkey"]),
    ]
)
