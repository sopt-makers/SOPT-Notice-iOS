//
//  AuthPushAlarmRepository.swift
//  Presentation
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Core
import Domain
import Network

public class AuthPushAlarmRepository {
    
    private let networkService: AuthService
    private let cancelBag = CancelBag()
    
    public init(service: AuthService) {
        self.networkService = service
    }
}

extension AuthPushAlarmRepository: AuthPushAlarmRepositoryInterface {
    
}
