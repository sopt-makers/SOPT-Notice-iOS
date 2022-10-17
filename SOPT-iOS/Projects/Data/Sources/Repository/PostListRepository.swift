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
    private let cancelBag = Set<AnyCancellable>()
    
    public init(service: PostListServiceType) {
        self.networkService = service
    }
}

extension PostListRepository: PostListRepositoryInterface {
    
}
