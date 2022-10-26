//
//  PushAlarmSettingModel.swift
//  Domain
//
//  Created by devxsby on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

public struct PushAlarmSettingModel {
    
    public let all, plan, design, ios, android, web, server: Bool

    public init(all: Bool, plan: Bool, design: Bool, ios: Bool, android: Bool, web: Bool, server: Bool) {
        self.all = all
        self.plan = plan
        self.design = design
        self.ios = ios
        self.android = android
        self.web = web
        self.server = server
    }
}
