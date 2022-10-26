//
//  AuthPushAlarmRepositoryInterface.swift
//  Presentation
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

public protocol AuthPushAlarmRepositoryInterface {
    func postPartList(list: [String])
    func postEmptyList()
}
