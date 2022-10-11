//
//  ModuleFactory.swift
//  SOPT-iOS
//
//  Created by 양수빈 on 2022/10/06.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

import Presentation
import Network
import Domain
import Data

public class ModuleFactory {
    static let shared = ModuleFactory()
    private init() { }
    
}

extension ModuleFactory: ModuleFactoryInterface {
    
    public func makePostDetailVC() -> Presentation.PostDetailVC {
        let repository = PostDetailRepository(service: BaseService.default)
        let useCase = DefaultPostDetailUseCase(repository: repository)
        let viewModel = PostDetailViewModel(useCase: useCase)
        let PostDetailVC = PostDetailVC()
        PostDetailVC.viewModel = viewModel
        return PostDetailVC
    }
}
