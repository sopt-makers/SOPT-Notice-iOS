//
//  PushAlarmSettingRepository.swift
//  Presentation
//
//  Created by devxsby on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Core
import Domain
import Network

public class PushAlarmSettingRepository {
    
    private let networkService: AlertService
    private let cancelBag = CancelBag()
    
    public init(service: AlertService) {
        self.networkService = service
    }
}

extension PushAlarmSettingRepository: PushAlarmSettingRepositoryInterface {
    
}
