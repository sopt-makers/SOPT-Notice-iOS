//
//  PostListUseCase.swift
//  Domain
//
//  Created by sejin on 2022/10/18.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Core
import Network

public protocol PostListUseCase {
    func getSearch(query: String)
    func getPostList(partName: String)
    var searchList: PassthroughSubject<[PostListModel], Error> { get set }
    var postList: PassthroughSubject<[PostListModel], Error> { get set }
}

public class DefaultPostListUseCase {
  
    private let repository: PostListRepositoryInterface
    private var cancelBag = CancelBag()
    public var searchList = PassthroughSubject<[PostListModel], Error>()
    public var postList =  PassthroughSubject<[PostListModel], Error>()
    
    public init(repository: PostListRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultPostListUseCase: PostListUseCase {
    
    public func getSearch(query: String) {
        repository.getSearchResult(str: query)
            .sink(receiveCompletion: { event in
                print("completion: \(event)")
            }, receiveValue: { entity in
                guard let entity = entity else { return }
                self.searchList.send(entity)
            })
            .store(in: cancelBag)
    }
    
    public func getPostList(partName: String) {
        repository.getPostListResult(partName: partName)
            .sink { event in
                print("completion: \(event)")
            } receiveValue: { entity in
                guard let entity = entity else { return }
                self.postList.send(entity)
            }
            .store(in: cancelBag)
    }
}
