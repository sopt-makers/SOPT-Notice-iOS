//
//  SettingRepository.swift
//  Presentation
//
//  Created by devxsby on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Domain
import Network

public class SettingRepository {
    
    private let networkService: SettingServiceType
    private let cancelBag = Set<AnyCancellable>()
    
    public init(service: SettingServiceType) {
        self.networkService = service
    }
}

extension SettingRepository: SettingRepositoryInterface {
    
}
