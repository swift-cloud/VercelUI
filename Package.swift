// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "VercelUI",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        .library(name: "VercelUI", targets: ["VercelUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-cloud/Vercel", from: "1.2.0"),
        .package(url: "https://github.com/TokamakUI/Tokamak", from: "0.11.1")
    ],
    targets: [
        .target(name: "VercelUI", dependencies: [
            "Vercel",
            .product(name: "TokamakStaticHTML", package: "Tokamak")
        ])
    ]
)
