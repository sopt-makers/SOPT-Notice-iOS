//
//  NoticeAPI.swift
//  Network
//
//  Created by Junho Lee on 2022/10/16.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation
import UIKit

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
                                               images: self.noticeSampleImages,
                                               content: self.noticeSampleContent,
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

extension NoticeAPI {
    var noticeSampleContent: String {
        return
    """
    안녕하세요! 함께하게 된 여러분 환영합니다!
    
    드디어 기다리고 기다리던  OT가 내일입니다!
    OT를 준비하고 있는 임원진들도 여러분들을 만나뵐 생각에 너무나 설레고 기뻐요!!😆
    
    OT는 코로나19로 인해 온라인으로 진행될 예정입니다.
    하지만 *길드별 오프라인*으로도 진행되니 많은 기대 부탁드립니다!
    
    📌OT는 필히 참석 부탁드립니다.
    불참이나 지각 시 각 파트장에게 명확한 사유를 전달해주시기 바라며,
    전체 출석 점수인 2점에서 지각 시에는 -0.5점, 결석 시에는 -1점이 적용됩니다.
    
    출석에 대해서는 OT에서 더 자세히 공지드리겠습니다.
    
    OT 타임라인과 확인 사항을 말씀드리겠습니다!
    
    📌 타임라인
    14:00 ~ 14:30 줌 접속 & 출석 인증
    14:30 ~ 15:00 SOPT & 임원진 소개
    15:00 ~ 15:30 SOPT 임원진 공지
    15:30 ~ 15:50 쉬는시간
    15:50 ~ 16:20 운영팀 레크레이션
    16:20 ~ 16:50 파트별 시간
    
    📌 꼭 확인해주세요!!
    
    ✅ OT 참석에 지장이 없는 환경에서 접속해주세요!
    이동하면서 모바일로 듣거나 다른 일정과 병행하는 것을 삼가주시기 바랍니다.🙏
    해당 사항 확인 시 바로 결석 처리될 예정입니다.
    
    ✅ 시간을 맞춰 출석 인증해주세요!
    출석 체크 시 자리에 없으시면 출석으로 인정받으실 수 없습니다.❗
    출석 체크는 불시에 여러 차례 진행될 예정이니, 와이파이 상태 및 주변 상황을 항상 체크해주세요.
    
    ✅ OT 진행 중에는 모두 카메라를 켜주세요!
    원활한 진행 및 출석을 위함이니, 꼭 지켜주시면 감사하겠습니다. 📷
    사전 양해 없이 5분 이상⏰ 카메라를 키지 않으실 경우, 결석 처리됩니다.
    
    
    👉 OT에 참석하기 어려운 피치 못할 사정이 있으신 경우, 꼭‼️ 미리 각 파트장에게 말씀해주세요.  🙌
    
    원활한 OT 진행을 위한 유의사항들이니 꼭 확인해주시면 감사하겠습니다!🙏🏼
    내일 OT에서 뵙겠습니다〰
    """
    }
    
    var noticeSampleImages: [String] {
        let scale:Int = Int(UIScreen.main.scale)
        let height:Int = Int(812) * scale
        let width:Int = Int(375) * scale
        
        return ["https://dummyimage.com/\(width)x\(height)/09a/fff.png&text=Image+1", "https://dummyimage.com/\(600)x\(600)/09b/fff.png&text=Image+2",
                "https://dummyimage.com/\(width)x\(height)/09c/fff.png&text=Image+3",
                "https://dummyimage.com/\(600)x\(600)/09d/fff.png&text=Image+4",
                "https://dummyimage.com/\(width)x\(height)/09e/fff.png&text=Image+5",
                "https://dummyimage.com/\(width)x\(height)/09f/fff.png&text=Image+6"
        ]
    }
}
