//
//  AuthSignUpRepository.swift
//  Data
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Core
import Domain
import Network

public class AuthSignUpRepository {
    
    private let networkService: AuthService
    private let cancelBag = CancelBag()
    
    public init(service: AuthService) {
        self.networkService = service
    }
}

extension AuthSignUpRepository: AuthSignUpRepositoryInterface {
    public func postAuthEmail(email: String) -> AnyPublisher<AuthSignUpModel?, Error> {
        return makeAuthEmailEntity(email: email)
    }
}

extension AuthSignUpRepository {
    private func makeAuthEmailEntity(email: String) -> AnyPublisher<AuthSignUpModel?, Error> {
        networkService.postAuthEmail(email: email, token: "dummy-token")
            .compactMap { $0?.toDomain() }
            .eraseToAnyPublisher()
    }
}
