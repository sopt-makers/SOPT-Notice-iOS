//
//  AuthPushAlarmUseCase.swift
//  Presentation
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Core

public protocol AuthPushAlarmUseCase {

}

public class DefaultAuthPushAlarmUseCase {
  
    private let repository: AuthPushAlarmRepositoryInterface
    private var cancelBag = CancelBag()
  
    public init(repository: AuthPushAlarmRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultAuthPushAlarmUseCase: AuthPushAlarmUseCase {
  
}
