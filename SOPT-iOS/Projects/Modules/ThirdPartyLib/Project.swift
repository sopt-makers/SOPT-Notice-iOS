//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by sejin on 2022/10/02.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "ThirdPartyLib",
    product: .framework,
    packages: [],
    dependencies: [
        .external(name: "SnapKit"),
        .external(name: "Then"),
        .external(name: "Kingfisher"),
        .external(name: "Moya")
    ]
)
