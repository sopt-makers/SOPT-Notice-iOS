//
//  PostListModel.swift
//  Presentation
//
//  Created by sejin on 2022/10/18.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

public struct PostListModel: Hashable {
    public let isNew: Bool
    public let title, writer, date: String
    
    public init(isNew: Bool, title: String, writer: String, date: String) {
        self.isNew = isNew
        self.title = title
        self.writer = writer
        self.date = date
    }
}
