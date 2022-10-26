//
//  PostDetailModel.swift
//  Domain
//
//  Created by Junho Lee on 2022/10/10.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

import ImageSlideShow

public struct PostDetailModel {
    public let title: Title
    public let images: [Image]
    public let content: Content
    
    public init(title: Title, images: [Image], content: Content) {
        self.title = title
        self.images = images
        self.content = content
    }
}

extension PostDetailModel {
    public struct Title: Hashable {
        public let title: String
        public let writer: String
        public let date: String
        
        public init(title: String, writer: String, date: String) {
            self.title = title
            self.writer = writer
            self.date = date
        }
    }
}

extension PostDetailModel {
    public struct Image: Hashable {
        public let imageURL: String
        
        public init(imageURL: String) {
            self.imageURL = imageURL
        }
    }
}

extension PostDetailModel {
    public struct Content: Hashable {
        public let content: String
        
        public init(content: String) {
            self.content = content
        }
    }
}
