//
//  PartCategory.swift
//  Core
//
//  Created by 양수빈 on 2022/10/27.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

public enum PartCategory: String, Codable {
    case fullNotice = "all"
    case plan = "plan"
    case design = "design"
    case ios = "iOS"
    case android = "android"
    case web = "web"
    case server = "server"
}
