//
//  PushAlarmSettingModel.swift
//  Domain
//
//  Created by devxsby on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

public struct PushAlarmSettingModel {
    
    public let pushSettingList: [Bool]

    public init(settingList: [Bool]) {
        self.pushSettingList = settingList
    }
}
