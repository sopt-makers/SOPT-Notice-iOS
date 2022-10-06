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

protocol ModuleFactoryProtocol {
    func makeSampleVC() -> SampleVC
}

open class ModuleFactory: ModuleFactoryProtocol {
  static let shared = ModuleFactory()
  private init() { }

  public func makeSampleVC() -> SampleVC {
      let repository = SampleRepository(service: BaseService.self as! SampleServiceType)
      let useCase = DefaultSampleUseCase(repository: repository)
    let viewModel = SampleViewModel(useCase: useCase)
    let sampleVC = SampleVC.controllerFromStoryboard(.sample)
    sampleVC.viewModel = viewModel
    return sampleVC
  }
}
