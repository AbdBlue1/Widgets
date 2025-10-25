// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "NationalRailWidget",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "NationalRailWidget",
            targets: ["NationalRailWidget"])
    ],
    targets: [
        .target(
            name: "NationalRailWidget",
            path: "."
        )
    ]
)
