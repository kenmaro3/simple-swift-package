// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "simpleSwiftPackage",
    defaultLocalization: "ja",   // - NEW
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "simpleSwiftPackage",
            targets: ["simpleSwiftPackage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kenmaro3/TRETJapanNFCReader.git", from: "0.0.0"),
        .package(url: "https://github.com/filom/ASN1Decoder.git", from: "1.9.0"),
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.8.0"),
        .package(url: "https://github.com/apple/swift-asn1", from: "0.10.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "simpleSwiftPackage",
            dependencies: [
                .product(name: "TRETJapanNFCReader-MIFARE-IndividualNumber", package: "TRETJapanNFCReader"),      // (1)
                .product(name: "ASN1Decoder", package: "ASN1Decoder"),
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "SwiftASN1", package: "swift-asn1")
            ],
            resources: [.process("Resources")]), // - NEW
        .testTarget(
            name: "simpleSwiftPackageTests",
            dependencies: ["simpleSwiftPackage"]),
    ]
)
