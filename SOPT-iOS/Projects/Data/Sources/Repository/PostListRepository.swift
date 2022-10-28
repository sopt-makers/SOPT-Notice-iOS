//
//  PostListRepository.swift
//  Presentation
//
//  Created by sejin on 2022/10/18.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Core
import Domain
import Network

public class PostListRepository {
    
    private let networkService: NoticeService
    private var cancelBag = CancelBag()
    
    public init(service: NoticeService) {
        self.networkService = service
    }
}

extension PostListRepository: PostListRepositoryInterface {
    public func getSearchResult(str: String) -> AnyPublisher<[PostListModel]?, Error> {
        return makeMockSearchResultEntity()
    }
    
    public func getPostListResult(partName: String) -> AnyPublisher<[PostListModel]?, Error> {
        return makeMokePostListResultEntity(partName: partName)
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
    
    private func makeMokePostListResultEntity(partName: String) -> AnyPublisher<[PostListModel]?, Error> {
        let mockPostListData = [
            PostListData(noticeID: 1, title: "31th SOPT OT 공지 - \(partName)", creator: "관리", createdAt: "2022.5.13"),
            PostListData(noticeID: 2, title: "31th SOPT 1차 행사 공지 - \(partName)", creator: "관리", createdAt: "2022.6.10"),
            PostListData(noticeID: 4, title: "31th SOPT 앱잼 공지 - \(partName)", creator: "관리", createdAt: "2022.12.1")
        ]
        let mockSearch = PostListEntity(notices: mockPostListData)
        let model = mockSearch.toDomain()
        return Just(model)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
    }
}
