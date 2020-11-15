// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "MiCasaUI",
  platforms: [.macOS(.v10_15)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(name: "MiCasaUI", type: .dynamic, targets: ["MiCasaUI"]),
    .executable(name: "MiCasaUITestApp", targets: ["MiCasaUITestApp"])
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    .package(url: "https://github.com/MiCasa-HomeKit/MiCasaPlugin.git", .branch("main")),
    .package(url: "https://github.com/MiCasa-HomeKit/HAP.git", .branch("master")),
    .package(name: "Swifter", url: "https://github.com/httpswift/swifter.git", .branch("stable")),
    .package(url: "https://github.com/Quick/Quick", from: "2.0.0"),
    .package(url: "https://github.com/Quick/Nimble", from: "8.0.0"),
    .package(url: "https://github.com/realm/SwiftLint.git", from: "0.40.3")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .target(name: "MiCasaUI", dependencies: ["MiCasaPlugin", "HAP", "Swifter"], resources: [.copy("Resources")]),
    .target(name: "MiCasaUITestApp", dependencies: ["MiCasaPlugin", "HAP", "MiCasaUI"]),
    .testTarget(name: "MiCasaUITests", dependencies: ["MiCasaUI", "HAP", "Quick", "Nimble", "MiCasaPlugin"])
  ]
)
