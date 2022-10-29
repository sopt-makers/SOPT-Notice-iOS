//
//  AuthSignUpModel.swift
//  Domain
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

public struct AuthSignUpModel: Hashable {
    public let userId: Int

    public init(userId: Int) {
        self.userId = userId
    }
}
