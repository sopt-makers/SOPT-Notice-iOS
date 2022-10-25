//
//  PostListRepository.swift
//  Presentation
//
//  Created by sejin on 2022/10/18.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Domain
import Network

public class PostListRepository {
    
    private let networkService: PostListServiceType
    private var cancelBag = Set<AnyCancellable>()
    
    public init(service: PostListServiceType) {
        self.networkService = service
    }
}

extension PostListRepository: PostListRepositoryInterface {
    public func getSearchResult(str: String) -> AnyPublisher<[PostListModel]?, Error> {
        return makeMockSearchResultEntity()
    }
}

extension PostListRepository {
    private func makeMockSearchResultEntity() -> AnyPublisher<[PostListModel]?, Error> {
        let mockSearchData = [
            PostSearchData(noticeID: 1, title: "31th SOPT OT 공지", creator: "관리", createdAt: "2000.1.1"),
            PostSearchData(noticeID: 2, title: "3@th SOPT OT 공지", creator: "관리", createdAt: "1999.1.1"),
            PostSearchData(noticeID: 4, title: "3--th SOPT OT 공지", creator: "관리", createdAt: "10.1.1")
        ]
        let mockSearch = PostSearchEntity(notices: mockSearchData)
        let model = mockSearch.toDomain()
        return Just(model)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
    }
}
