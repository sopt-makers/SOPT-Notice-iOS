//
//  AuthSignUpTransform.swift
//  Presentation
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

import Domain
import Network

extension AuthSignUpEntity {

    public func toDomain() -> AuthSignUpModel {
        return AuthSignUpModel.init(userId: self.userId, message: self.message)
    }
}
