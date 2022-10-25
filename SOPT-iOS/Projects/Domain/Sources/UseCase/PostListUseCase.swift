//
//  PostListUseCase.swift
//  Domain
//
//  Created by sejin on 2022/10/18.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Network

public protocol PostListUseCase {
    func getSearch(query: String)
    var searchList: PassthroughSubject<[PostListModel], Error> { get set }
}

public class DefaultPostListUseCase {
  
    private let repository: PostListRepositoryInterface
    private var cancelBag = Set<AnyCancellable>()
    public var searchList = PassthroughSubject<[PostListModel], Error>()
  
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
            .store(in: &cancelBag)
    }
}
