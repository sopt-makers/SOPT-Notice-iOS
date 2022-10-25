//
//  AuthSignUpRepository.swift
//  Presentation
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Domain
import Network

public class AuthSignUpRepository {
    
    private let networkService: AuthSignUpServiceType
    private let cancelBag = Set<AnyCancellable>()
    
    public init(service: AuthSignUpServiceType) {
        self.networkService = service
    }
}

extension AuthSignUpRepository: AuthSignUpRepositoryInterface {
    
}
