//
//  PostDetailUseCase.swift
//  Domain
//
//  Created by Junho Lee on 2022/10/10.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

public protocol PostDetailUseCase {

}

public class DefaultPostDetailUseCase {
  
    private let repository: PostDetailRepositoryInterface
    private var cancelBag = Set<AnyCancellable>()
  
    public init(repository: PostDetailRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultPostDetailUseCase: PostDetailUseCase {
  
}
