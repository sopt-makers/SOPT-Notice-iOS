//
//  BaseAPI.swift
//  Network
//
//  Created by 양수빈 on 2022/10/06.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Alamofire
import Moya
import Foundation

enum APIType {
    case notice
    case auth
    case alert
}

protocol BaseAPI: TargetType {
    static var apiType: APIType { get set }
}

extension BaseAPI {
    var baseURL: URL {
        var base = Config.Network.baseURL
        
        switch Self.apiType {
        case .alert:
            base += "alert"
        case .notice:
            base += "notice"
        case .auth:
            base += "auth"
        }
        
        guard let url = URL(string: base) else {
            fatalError("baseURL could not be configured")
        }
        return url
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
