//
//  AuthSignUpUseCase.swift
//  Presentation
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

public protocol AuthSignUpUseCase {

}

public class DefaultAuthSignUpUseCase {
  
    private let repository: AuthSignUpRepositoryInterface
    private var cancelBag = Set<AnyCancellable>()
  
    public init(repository: AuthSignUpRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultAuthSignUpUseCase: AuthSignUpUseCase {
  
}
