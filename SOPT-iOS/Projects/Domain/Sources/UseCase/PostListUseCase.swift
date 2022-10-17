//
//  PostListUseCase.swift
//  Presentation
//
//  Created by sejin on 2022/10/18.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

public protocol PostListUseCase {

}

public class DefaultPostListUseCase {
  
    private let repository: PostListRepositoryInterface
    private var cancelBag = Set<AnyCancellable>()
  
    public init(repository: PostListRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultPostListUseCase: PostListUseCase {
  
}
