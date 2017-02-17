//
//  Package.swift
//  VabeExample
//
//  Created by Valentin Bercot on 17/02/2017.
//
//

import PackageDescription

let package = Package(
    name: "VabeExample",
    targets: [
        Target(
            name: "VabePresentation",
            dependencies: []
        )
    ],
    dependencies: [
        .Package(
            url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git",
            versions: Version(0,0,0) ..< Version(10,0,0)
        ),
        .Package(
            url: "https://github.com/PerfectlySoft/Perfect-MySQL.git",
            versions: Version(0,0,0) ..< Version(10,0,0)
        )
    ],
    exclude: []
)
