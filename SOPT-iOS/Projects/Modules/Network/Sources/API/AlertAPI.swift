//
//  AlertAPI.swift
//  Network
//
//  Created by Junho Lee on 2022/10/16.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

import Alamofire
import Moya

public enum AlertAPI {
    case sample(provider: String)
    case restaurant
    case fetchPushSetting
}

extension AlertAPI: BaseAPI {
    
    public static var apiType: APIType = .alert
    
    // MARK: - Path
    public var path: String {
        switch self {
        case .sample:
            return ""
        default:
            return ""
        }
    }
    
    // MARK: - Method
    public var method: Moya.Method {
        switch self {
        case .sample:
            return .post
        default:
            return .get
        }
    }
    
    // MARK: - Parameters
    /// - note :
    ///  post를 할때, body Parameter를 담아서 전송해야하는 경우가 있는데,
    ///  이 경우에 사용하는 부분입니다.
    ///
    ///  (get에서는 사용 ❌, get의 경우에는 쿼리로)
    ///
    private var bodyParameters: Parameters? {
        var params: Parameters = [:]
        switch self {
        case .sample(let provider):
            params["platform"] = provider
        case .restaurant:
            params["category"] = ""
            params["longitude"] = 126.95153705076048
            params["zoom"] = 10000000.0
            params["latitude"] = 37.504551862886466
        default:
            return nil
        }
        return params
    }
    
    /// - note :
    ///  query문을 사용하는 경우 URLEncoding 을 사용해야 합니다
    ///  나머지는 그냥 전부 다 default 처리.
    ///
    private var parameterEncoding : ParameterEncoding{
        switch self {
        case .sample, .restaurant:
            return URLEncoding.init(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal)
        default :
            return JSONEncoding.default
        }
    }
    
    /// - note :
    ///  body Parameters가 있는 경우 requestParameters  case 처리.
    ///  일반적인 처리는 모두 requestPlain으로 사용.
    ///
    public var task: Task {
        switch self {
        case .sample:
            return .requestParameters(parameters: bodyParameters ?? [:], encoding: parameterEncoding)
        case .restaurant:
            return .requestParameters(parameters: bodyParameters ?? [:], encoding: parameterEncoding)
        default:
            return .requestPlain
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .fetchPushSetting:
            let entity = PushAlarmSettingEntity(alerts: [
                Alert(part: .fullNotice, isAlert: true),
                Alert(part: .plan, isAlert: false),
                Alert(part: .design, isAlert: false),
                Alert(part: .ios, isAlert: true),
                Alert(part: .android, isAlert: false),
                Alert(part: .web, isAlert: false),
                Alert(part: .server, isAlert: false)
            ])
            
            if let data = try? JSONEncoder().encode(entity) {
                return data
            } else {
                return Data()
            }
        default:
            return Data()
        }
    }
}
