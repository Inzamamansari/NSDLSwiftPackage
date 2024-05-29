// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NSDLSwiftPackage",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "NSDLSwiftPackage",
            targets: ["NSDLSwiftPackage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.9.1"))
    ],
    targets: [
        .target(
            name: "NSDLSwiftPackage",
            dependencies: ["Alamofire"]),
    ]
)
