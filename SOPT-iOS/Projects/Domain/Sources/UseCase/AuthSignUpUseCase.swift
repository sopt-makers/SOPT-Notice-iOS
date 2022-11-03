//
//  AuthSignUpUseCase.swift
//  Domain
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Core
import Network

public protocol AuthSignUpUseCase {
    func postAuthEmail(email: String)
    var authSignUpModel: PassthroughSubject<AuthSignUpModel, Error> { get set }
}

public class DefaultAuthSignUpUseCase {
  
    private let repository: AuthSignUpRepositoryInterface
    private var cancelBag = CancelBag()
    public var authSignUpModel = PassthroughSubject<AuthSignUpModel, Error>()
  
    public init(repository: AuthSignUpRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultAuthSignUpUseCase: AuthSignUpUseCase {
    public func postAuthEmail(email: String) {
        repository.postAuthEmail(email: email)
            .sink { event in
                print("completion: \(event)")
            } receiveValue: { entity in
                guard let entity = entity else { return }
                self.authSignUpModel.send(entity)
            }
            .store(in: cancelBag)
    }
}
