//
//  AuthSignUpEntity.swift
//  Presentation
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

public struct AuthSignUpEntity: Codable {
    public let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}
