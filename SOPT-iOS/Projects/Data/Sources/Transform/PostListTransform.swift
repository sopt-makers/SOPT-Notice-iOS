//
//  PostListTransform.swift
//  Data
//
//  Created by sejin on 2022/10/19.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

import Domain
import Network

extension PostListEntity {
    public func toDomain() -> [PostListModel] {
        let noticeList = self.notices.map { entity in
            return PostListModel.init(isNew: false, title: entity.title, writer: entity.creator, date: entity.createdAt)
        }
        return noticeList
    }
}
