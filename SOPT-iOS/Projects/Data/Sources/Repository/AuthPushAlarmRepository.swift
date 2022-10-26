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
    
    private let networkService: AlertService
    private let cancelBag = CancelBag()
    
    public init(service: AlertService) {
        self.networkService = service
    }
}

extension AuthPushAlarmRepository: AuthPushAlarmRepositoryInterface {
    public func postPartList(list: [String]) -> AnyPublisher<Int, Error> {
        networkService.postUserPushPartList(partList: list)
    }
    
    public func postEmptyList() {
        print("레포지토리 엠프티 성공")
    }
}
