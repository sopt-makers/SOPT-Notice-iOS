//
//  PushAlarmSettingRepositoryInterface.swift
//  Domain
//
//  Created by devxsby on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

public protocol PushAlarmSettingRepositoryInterface {
    func fetchPushListSetting() -> AnyPublisher<PushAlarmSettingModel, Error>
    func editPushListSetting(partList: [String]) -> AnyPublisher<Int, Error>
}
