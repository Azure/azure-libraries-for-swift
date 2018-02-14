// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription
let package = Package(
    name: "appservice",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "appservice",
            targets: ["appservice"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "4.0.10"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "3.4.2"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "3.1.4"),
        .package(url: "git@github.com:alvadb/autorest-clientruntime-for-swift.git", .branch("master"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "appservice",
            dependencies: ["Alamofire", "RxSwift", "SwiftyJSON", "azureSwiftRuntime"])
    ]
)
