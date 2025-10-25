// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "TfLStationWidget",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "TfLStationWidget",
            targets: ["TfLStationWidget"])
    ],
    targets: [
        .target(
            name: "TfLStationWidget",
            path: "."
        )
    ]
)
