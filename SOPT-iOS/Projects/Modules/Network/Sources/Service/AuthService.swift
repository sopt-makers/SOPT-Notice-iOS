//
//  AuthService.swift
//  Network
//
//  Created by Junho Lee on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation
import Combine

import Alamofire
import Moya

public typealias DefaultAuthService = BaseService<AuthAPI>

public protocol AuthService {
    func postAuthEmail(email: String, token: String) -> AnyPublisher<AuthSignUpEntity?, Error>
}

extension DefaultAuthService: AuthService {
    public func postAuthEmail(email: String, token: String) -> AnyPublisher<AuthSignUpEntity?, Error> {
        return test.requestObjectInCombine(.postAuthEmail(email: email, token: token))
    }
}
