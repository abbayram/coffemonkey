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
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.0.0")
    ],
    targets: [
        .target(
            name: "coffemonkey",
            dependencies: [
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
                "LogoAnimationView"
            ]),
        .testTarget(
            name: "coffemonkeyTests",
            dependencies: ["coffemonkey"]),
    ]
)
