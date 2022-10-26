//
//  PostDetailTransform.swift
//  Data
//
//  Created by 양수빈 on 2022/10/19.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

import Domain
import Network

extension PostDetailEntity {
    public func toDomain() -> PostDetailModel {
        let title = PostDetailModel.Title.init(title: self.title,
                                               writer: self.creator,
                                               date: self.createdAt)
        let images = self.images.map {
            PostDetailModel.Image(imageURL: $0)
        }
        let content = PostDetailModel.Content.init(content: self.content)
        return PostDetailModel.init(title: title,
                                    images: images,
                                    content: content)
    }
}
