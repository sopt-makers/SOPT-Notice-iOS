//
//  PostListEntity.swift
//  Network
//
//  Created by sejin on 2022/10/19.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

// MARK: - PostListEntity

public struct PostListEntity: Codable {
    public let notices: [PostListData]
    
    public init(notices: [PostListData]) {
        self.notices = notices
    }
}

// MARK: - Notice

public struct PostListData: Codable {
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
