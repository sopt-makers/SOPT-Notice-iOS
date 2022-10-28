//
//  PushAlarmSettingEntity.swift
//  Network
//
//  Created by devxsby on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

import Core

// MARK: - PushAlarmSettingEntity
public struct PushAlarmSettingEntity: Codable {
    public let alerts: [Alert]
}

// MARK: - Alert
public struct Alert: Codable {
    public let part: String
    public let isAlert: Bool
}
