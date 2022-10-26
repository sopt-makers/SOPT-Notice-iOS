//
//  AlertService.swift
//  Network
//
//  Created by Junho Lee on 2022/10/16.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation
import Combine

import Alamofire
import Moya

public typealias DefaultAlertService = BaseService<AlertAPI>

public protocol AlertService {
    func postUserPushPartList(partList: [String]) -> AnyPublisher<Int, Error>
}

extension DefaultAlertService: AlertService {
    public func postUserPushPartList(partList: [String]) -> AnyPublisher<Int, Error> {
        test.requestObjectInCombineNoResult(.postUserPushPartList(partList: partList))
    }
}
