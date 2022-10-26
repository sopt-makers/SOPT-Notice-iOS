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
        var alert: [PartCategory: Bool] = [:]
        self.alerts.forEach {
            alert.updateValue($0.isAlert, forKey: $0.part)
        }
        return PushAlarmSettingModel.init(all: alert[PartCategory.fullNotice] ?? false,
                                          plan: alert[PartCategory.plan] ?? false,
                                          design: alert[PartCategory.design] ?? false,
                                          ios: alert[PartCategory.ios] ?? false,
                                          android: alert[PartCategory.android] ?? false,
                                          web: alert[PartCategory.web] ?? false,
                                          server: alert[PartCategory.server] ?? false)
    }
}
