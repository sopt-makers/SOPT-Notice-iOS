//
//  PostDetailRepository.swift
//  Presentation
//
//  Created by Junho Lee on 2022/10/10.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Core
import Domain
import Network

public class PostDetailRepository {
    private let networkService: NoticeService
    private var cancelBag = CancelBag()
    
    public init(service: NoticeService) {
        self.networkService = service
    }
}

extension PostDetailRepository: PostDetailRepositoryInterface {
    public func fetchPostDetail(noticeId: Int) -> AnyPublisher<PostDetailModel, Error> {
        networkService.fetchNotcieDetail(noticeId: noticeId)
            .compactMap { $0?.toDomain() }
            .eraseToAnyPublisher()
    }
}
