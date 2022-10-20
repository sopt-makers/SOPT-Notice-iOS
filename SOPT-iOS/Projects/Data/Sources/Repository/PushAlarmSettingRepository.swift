//
//  PushAlarmSettingRepository.swift
//  Presentation
//
//  Created by devxsby on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Domain
import Network

public class PushAlarmSettingRepository {
    
    private let networkService: PushAlarmSettingServiceType
    private let cancelBag = Set<AnyCancellable>()
    
    public init(service: PushAlarmSettingServiceType) {
        self.networkService = service
    }
}

extension PushAlarmSettingRepository: PushAlarmSettingRepositoryInterface {
    
}
