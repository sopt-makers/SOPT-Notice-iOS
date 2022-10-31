//
//  AuthSignUpEntity.swift
//  Presentation
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

public struct AuthSignUpEntity: Codable {
    public let userId: Int?
    public let message: String?
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case message
    }
    
    public init(userId: Int?, message: String?) {
        self.userId = userId
        self.message = message
    }
}
