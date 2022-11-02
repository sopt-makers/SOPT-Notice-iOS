//
//  AuthSignUpModel.swift
//  Domain
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

public struct AuthSignUpModel: Hashable {
    public let userId: Int?
    public let message: String?

    public init(userId: Int?, message: String?) {
        self.userId = userId
        self.message = message
    }
}
