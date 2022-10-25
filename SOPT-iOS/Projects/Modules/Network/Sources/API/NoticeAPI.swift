//
//  NoticeAPI.swift
//  Network
//
//  Created by Junho Lee on 2022/10/16.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

import Alamofire
import Moya

public enum NoticeAPI {
    case fetchNotcieDetail(noticeId: Int)
}

extension NoticeAPI: BaseAPI {
    
    public static var apiType: APIType = .notice
    
    // MARK: - Path
    public var path: String {
        switch self {
        default:
            return ""
        }
    }
    
    // MARK: - Method
    public var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    // MARK: - Parameters
    private var bodyParameters: Parameters? {
        var params: Parameters = [:]
        switch self {
        case .fetchNotcieDetail(let noticeId):
            params["notice_id"] = noticeId
        }
        return params
    }
    
    private var parameterEncoding : ParameterEncoding{
        switch self {
        case .fetchNotcieDetail:
            return URLEncoding.init(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal)
        default :
            return JSONEncoding.default
        }
    }
    
    public var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .fetchNotcieDetail(let noticeId):
            let entity = PostDetailEntity.init(noticeID: noticeId,
                                               title: "샘플 제목",
                                               creator: "이준호",
                                               createdAt: "22.05.31",
                                               images: [],
                                               content: "샘플 컨텐트",
                                               part: "iOS",
                                               scope: "iOS")
            if let data = try? JSONEncoder().encode(entity) {
                return data
            } else {
                return Data()
            }
        }
    }
}
