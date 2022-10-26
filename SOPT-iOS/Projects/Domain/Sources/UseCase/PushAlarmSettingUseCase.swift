//
//  PushAlarmSettingUseCase.swift
//  Domain
//
//  Created by devxsby on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Core

public protocol PushAlarmSettingUseCase {

}

public class DefaultPushAlarmSettingUseCase {
  
    private let repository: PushAlarmSettingRepositoryInterface
    private var cancelBag = CancelBag()
  
    public init(repository: PushAlarmSettingRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultPushAlarmSettingUseCase: PushAlarmSettingUseCase {
  
}
