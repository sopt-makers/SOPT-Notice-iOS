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
    
    private let networkService: AlertService
    private let cancelBag = Set<AnyCancellable>()
    
    public init(service: AlertService) {
        self.networkService = service
    }
}

extension PostDetailRepository: PostDetailRepositoryInterface {
    
}
