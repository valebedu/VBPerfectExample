//
//  Package.swift
//  VBPerfectExample
//
//  Created by Valentin Bercot on 17/02/2017.
//
//

import PackageDescription

let package = Package(
    name: "VBPerfectExample",
    targets: [
        Target(
            name: "VBPerfectPresentation",
            dependencies: [
                "VBPerfectBusiness"
            ]
        ),
        Target(
            name: "VBPerfectBusiness",
            dependencies: [
                "VBPerfectPersistence",
                "VBPerfectEntities"
            ]
        ),
        Target(
            name: "VBPerfectPersistence",
            dependencies: [
                "VBPerfectEntities"
            ]
        ),
        Target(
            name: "VBPerfectEntities",
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
        ),
        .Package(
            url: "https://github.com/valentinbercot/VBPerfectArchitecture.git",
            versions: Version(0,0,0) ..< Version(10,0,0)
        ),
        .Package(
            url: "https://github.com/valentinbercot/VBPerfectMySQL.git",
            versions: Version(0,0,0) ..< Version(10,0,0)
        )
    ],
    exclude: []
)
