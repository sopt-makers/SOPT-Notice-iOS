//
//  AuthSignUpUseCase.swift
//  Presentation
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Core

public protocol AuthSignUpUseCase {

}

public class DefaultAuthSignUpUseCase {
  
    private let repository: AuthSignUpRepositoryInterface
    private var cancelBag = CancelBag()
  
    public init(repository: AuthSignUpRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultAuthSignUpUseCase: AuthSignUpUseCase {
  
}
