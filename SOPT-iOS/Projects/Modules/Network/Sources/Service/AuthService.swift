//
//  AuthService.swift
//  Network
//
//  Created by Junho Lee on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

public typealias DefaultAuthService = BaseService<AuthAPI>

public protocol AuthService {
    
}

extension DefaultAuthService: AuthService {
    
}