//
//  SampleRepository.swift
//  Data
//
//  Created by 양수빈 on 2022/10/06.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine
import Domain
import Network

open class SampleRepository {
    
    private let networkService: SampleServiceType
    private let cancelBag = Set<AnyCancellable>()

    public init(service: SampleServiceType) {
        self.networkService = service
    }
}

extension SampleRepository: SampleRepositoryInterface {
    
}
