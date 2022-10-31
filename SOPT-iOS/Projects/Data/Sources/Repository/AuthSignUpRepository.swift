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
        return makeMockAuthEmailEntity()
    }
}

extension AuthSignUpRepository {
    private func makeMockAuthEmailEntity() -> AnyPublisher<AuthSignUpModel?, Error> {
        let mockAuthEmail = AuthSignUpEntity(userId: 12345, message: nil)
        let model = mockAuthEmail.toDomain()
        return Just(model)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
