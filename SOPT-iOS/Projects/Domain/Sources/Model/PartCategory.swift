//
//  PartCategory.swift
//  Domain
//
//  Created by 양수빈 on 2022/10/28.
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

extension PartCategory {
    public static var allCases: [PartCategory] = [.fullNotice, .plan, .design, .ios, .android, .web, .server]
    
    public var title: String {
        switch self {
        case .fullNotice:
            return "전체 공지"
        case .plan:
            return "기획"
        case .design:
            return "디자인"
        case .ios:
            return "iOS"
        case .android:
            return "Android"
        case .web:
            return "Web"
        case .server:
            return "Server"
        }
    }
}
