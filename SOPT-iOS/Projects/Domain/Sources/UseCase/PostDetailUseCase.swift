//
//  PostDetailUseCase.swift
//  Domain
//
//  Created by Junho Lee on 2022/10/10.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

public protocol PostDetailUseCase {

    func fetchPostDetail(noticeId: Int)
    var postDetailModel: PassthroughSubject<PostDetailModel, Error> { get set }
}

public class DefaultPostDetailUseCase {
  
    private let repository: PostDetailRepositoryInterface
    private var cancelBag = Set<AnyCancellable>()
    public var postDetailModel = PassthroughSubject<PostDetailModel, Error>()
  
    public init(repository: PostDetailRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultPostDetailUseCase: PostDetailUseCase {
    public func fetchPostDetail(noticeId: Int) {
        repository.fetchPostDetail(noticeId: noticeId)
            .sink(receiveCompletion: { event in
                print("completion: \(event)")
            }, receiveValue: { entity in
                self.postDetailModel.send(entity)
            })
            .store(in: &cancelBag)
    }
}
