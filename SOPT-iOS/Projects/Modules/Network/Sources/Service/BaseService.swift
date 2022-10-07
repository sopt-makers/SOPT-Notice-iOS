//
//  BaseService.swift
//  Network
//
//  Created by 양수빈 on 2022/10/06.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Alamofire
import Moya
import Combine
import Foundation

// FIXME: - 수정

open class BaseService {
    public static let `default` = BaseService()
    var cancelBag = Set<AnyCancellable>()
    private init() {}
}
