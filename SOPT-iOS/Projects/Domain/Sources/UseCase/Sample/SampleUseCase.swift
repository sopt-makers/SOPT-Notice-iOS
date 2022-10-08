//
//  SapmleUseCase.swift
//  Domain
//
//  Created by 양수빈 on 2022/10/06.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

public protocol SampleUseCase {
    
}

public class DefaultSampleUseCase {
    
    private let repository: SampleRepositoryInterface
    private var cancelBag = Set<AnyCancellable>()
    
    public init(repository: SampleRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultSampleUseCase: SampleUseCase {
    
}
