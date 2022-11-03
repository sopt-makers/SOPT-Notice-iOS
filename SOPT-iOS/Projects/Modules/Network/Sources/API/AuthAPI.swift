//
//  AuthAPI.swift
//  Network
//
//  Created by Junho Lee on 2022/10/16.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

import Alamofire
import Moya

public enum AuthAPI {
    case postAuthEmail(email: String, token: String)
}

extension AuthAPI: BaseAPI {
    
    public static var apiType: APIType = .auth
    
    // MARK: - Path
    public var path: String {
        switch self {
        case .postAuthEmail:
            return "auth/send/email"
        }
    }
    
    // MARK: - Method
    public var method: Moya.Method {
        switch self {
        case .postAuthEmail:
            return .post
        }
    }
    
    // MARK: - Parameters
    private var bodyParameters: Parameters? {
        var params: Parameters = [:]
        switch self {
        case .postAuthEmail(let email, let token):
            params["email"] = email
            params["clientToken"] = token
            params["osType"] = "iOS"
        }
        return params
    }
    
    private var parameterEncoding: ParameterEncoding {
        switch self {
        case .postAuthEmail:
            return URLEncoding.init(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal)
        default:
            return JSONEncoding.default
        }
    }
    
    public var task: Task {
        switch self {
        case .postAuthEmail:
            return .requestParameters(parameters: bodyParameters ?? [:], encoding: parameterEncoding)
        default:
            return .requestPlain
        }
    }
}

extension AuthAPI {
    public var sampleData: Data {
        switch self {
        case .postAuthEmail:
            let mockValidAuthEntity = AuthSignUpEntity(userId: 12345, message: nil)
            let mockInvalidAuthEntity = AuthSignUpEntity(userId: nil, message: "등록되지 않은 메일입니다.")
            let sampleArray = [mockValidAuthEntity, mockInvalidAuthEntity]
            
            if let data = try? JSONEncoder().encode(sampleArray.randomElement()!) {
                return data
            } else {
                return Data()
            }
        }
    }
}
