//
//  PostDetailEntity.swift
//  Network
//
//  Created by Junho Lee on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

public struct PostDetailEntity: Codable {
    let noticeID: Int
    let title, creator, createdAt: String
    let images: [String]
    let content, part, scope: String

    enum CodingKeys: String, CodingKey {
        case noticeID = "notice_id"
        case title, creator, createdAt, images, content, part, scope
    }
}
