//
//  PostSearchEntity.swift
//  Network
//
//  Created by 양수빈 on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

// MARK: - PostSearchEntity
public struct PostSearchEntity: Codable {
    public let notices: [PostSearchData]
    
    public init(notices: [PostSearchData]) {
        self.notices = notices
    }
}

// MARK: - PostSearchData
public struct PostSearchData: Codable {
    public let noticeID: Int
    public let title, creator, createdAt: String

    enum CodingKeys: String, CodingKey {
        case noticeID = "notice_id"
        case title, creator, createdAt
    }
    
    public init(noticeID: Int, title: String, creator: String, createdAt: String) {
        self.noticeID = noticeID
        self.title = title
        self.creator = creator
        self.createdAt = createdAt
    }
}
