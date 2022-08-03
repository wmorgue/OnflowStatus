// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "OnflowNetwork",
	platforms: [.iOS(.v16)],
	products: [.library(name: "OnflowNetwork", targets: ["OnflowNetwork"])],
	dependencies: [.package(url: "https://github.com/Kean/Get.git", from: "1.0.1")],
	targets: [
		.target(
			name: "OnflowNetwork",
			dependencies: [.product(name: "Get", package: "Get")]
		),
		.testTarget(name: "OnflowNetworkTests", dependencies: ["OnflowNetwork"]),
	]
)
