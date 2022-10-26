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
    public func postPartList(list: [String]) {
        print("레포지토리 성공")
    }
    
    public func postEmptyList() {
        print("레포지토리 엠프티 성공")
    }
}
