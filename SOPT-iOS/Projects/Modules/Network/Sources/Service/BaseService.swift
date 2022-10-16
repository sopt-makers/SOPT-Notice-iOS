//
//  BaseService.swift
//  Network
//
//  Created by 양수빈 on 2022/10/06.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine
import Foundation

import Core

import Alamofire
import Moya

open class BaseService<Target: TargetType> {
    typealias API = Target
    
    var cancelBag = Set<AnyCancellable>()
    private init() {}
    public init() {}
    
    private lazy var provider: MoyaProvider<API> = {
        let provider = MoyaProvider<API>(endpointClosure: endpointClosure, session: DefaultAlamofireManager.shared)
        return provider
    }()
    
    private let endpointClosure = { (target: API) -> Endpoint in
        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        var endpoint: Endpoint = Endpoint(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, task: target.task, httpHeaderFields: target.headers)
        return endpoint
    }
    func requestObject<T: Decodable>(_ target: API, completion: @escaping (Result<T?, Error>) -> Void) {
        provider.request(target) { response in
            switch response {
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let body = try decoder.decode(ResponseObject<T>.self, from: value.data)
                    completion(.success(body.data))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                switch error {
                case .underlying(let error, _):
                    if error.asAFError?.isSessionTaskError ?? false {
                        
                    }
                default: break
                }
                completion(.failure(error))
            }
        }
    }
    
    func requestArray<T: Decodable>(_ target: API, completion: @escaping (Result<[T], Error>) -> Void) {
        provider.request(target) { response in
            switch response {
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let body = try decoder.decode(ResponseObject<[T]>.self, from: value.data)
                    completion(.success(body.data ?? []))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                switch error {
                case .underlying(let error, _):
                    if error.asAFError?.isSessionTaskError ?? false {
                        
                    }
                default: break
                }
                completion(.failure(error))
            }
        }
    }
    
    func requestObjectWithNoResult(_ target: API, completion: @escaping (Result<Int?, Error>) -> Void) {
        provider.request(target) { response in
            switch response {
            case .success(let value):
                
                completion(.success(value.statusCode))
                
            case .failure(let error):
                switch error {
                case .underlying(let error, _):
                    if error.asAFError?.isSessionTaskError ?? false {
                        
                    }
                default: break
                }
                completion(.failure(error))
            }
        }
    }
}
