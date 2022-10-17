//
//  SettingUseCase.swift
//  Presentation
//
//  Created by devxsby on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

public protocol SettingUseCase {

}

public class DefaultSettingUseCase {
  
    private let repository: SettingRepositoryInterface
    private var cancelBag = Set<AnyCancellable>()
  
    public init(repository: SettingRepositoryInterface) {
        self.repository = repository
    }
}

extension DefaultSettingUseCase: SettingUseCase {
  
}
