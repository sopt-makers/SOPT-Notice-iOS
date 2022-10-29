//
//  PushAlarmSettingTransform.swift
//  Data
//
//  Created by devxsby on 2022/10/19.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

import Domain
import Network

extension PushAlarmSettingEntity {
    
    public func toDomain() -> PushAlarmSettingModel {
        // TODO: - 순서 다르게 들어오면 변형, PartCategory 사용해서 변형
        let alert = self.alerts.map { $0.isAlert }
        return PushAlarmSettingModel(settingList: alert)
    }
}
