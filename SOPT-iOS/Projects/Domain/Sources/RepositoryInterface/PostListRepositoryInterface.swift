//
//  PostListRepositoryInterface.swift
//  Domain
//
//  Created by sejin on 2022/10/18.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Network

public protocol PostListRepositoryInterface {
    func getSearchResult(str: String) -> AnyPublisher<[PostListModel]?, Error>
}
