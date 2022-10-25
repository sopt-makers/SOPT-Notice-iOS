//
//  PostDetailRepository.swift
//  Presentation
//
//  Created by Junho Lee on 2022/10/10.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Domain
import Network

public class PostDetailRepository {
    
    private let networkService: NoticeService
    private var cancelBag = Set<AnyCancellable>()
    
    public init(service: NoticeService) {
        self.networkService = service
    }
}

extension PostDetailRepository: PostDetailRepositoryInterface {
    public func fetchPostDetail() {
        networkService.fetchNotcieDetail(noticeId: 3)
            .sink { error in
                print(error, "에러 발생")
            } receiveValue: { entity in
                if let entity { print(entity, "성공") }
            }.store(in: &cancelBag)
    }
}
