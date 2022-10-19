//
//  AlertService.swift
//  Network
//
//  Created by Junho Lee on 2022/10/16.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

import Alamofire
import Moya
import Combine

public typealias DefaultAlertService = BaseService<AlertAPI>

public protocol AlertService {
//    func getRestaurant() -> AnyPublisher<[MainMapEntity]?, Error>
//    func commonRestaurant(completion: @escaping (Result<[MainMapEntity]?, Error>) -> Void)
}

extension DefaultAlertService: AlertService {
//    public func getRestaurant() -> AnyPublisher<[MainMapEntity]?, Error> {
//        return requestObjectInCombine(.restaurant)
//    }
//
//    public func commonRestaurant(completion: @escaping (Result<[MainMapEntity]?, Error>) -> Void) {
//        return requestObject(.restaurant, completion: completion)
//    }
}
