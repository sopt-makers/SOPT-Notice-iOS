//
//  NoticeService.swift
//  Network
//
//  Created by Junho Lee on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation
import Combine

import Alamofire
import Moya

public typealias DefaultNoticeService = BaseService<NoticeAPI>

public protocol NoticeService {
    func fetchNotcieDetail(noticeId: Int) -> AnyPublisher<PostDetailEntity?, Error>
}

extension DefaultNoticeService: NoticeService {
    public func fetchNotcieDetail(noticeId: Int) -> AnyPublisher<PostDetailEntity?, Error> {
        return test.requestObjectInCombine(.fetchNotcieDetail(noticeId: noticeId))
    }
}
