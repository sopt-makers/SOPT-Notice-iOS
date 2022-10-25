//
//  PostSearchTransform.swift
//  Data
//
//  Created by 양수빈 on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

import Domain
import Network

extension PostSearchEntity {
    public func toDomain() -> [PostListModel] {
        let noticeList = self.notices.map { entity in
            return PostListModel.init(isNew: false, title: entity.title, writer: entity.creator, date: entity.createdAt)
        }
        return noticeList
    }
}
