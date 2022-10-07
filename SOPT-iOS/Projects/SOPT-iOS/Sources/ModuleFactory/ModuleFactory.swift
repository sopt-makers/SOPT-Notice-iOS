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
    public func makeSampleVC() -> Presentation.SampleVC {
        let repository = SampleRepository(service: BaseService.default)
        let useCase = DefaultSampleUseCase(repository: repository)
        let viewModel = SampleViewModel(useCase: useCase)
        let sampleVC = SampleVC.controllerFromStoryboard(.sample)
        sampleVC.viewModel = viewModel
        sampleVC.factory = self
        return sampleVC
    }
}
