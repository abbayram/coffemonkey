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
        .package(url: "https://github.com/google/GoogleSignIn-iOS.git", from: "6.0.0")
    ],
    targets: [
        .target(
            name: "coffemonkey",
            dependencies: [
                .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
                .product(name: "GoogleSignIn", package: "GoogleSignIn-iOS"),
                "LogoAnimationView"
            ]),
        .testTarget(
            name: "coffemonkeyTests",
            dependencies: ["coffemonkey"]),
    ]
)
