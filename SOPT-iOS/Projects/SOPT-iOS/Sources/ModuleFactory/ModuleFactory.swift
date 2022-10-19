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
    
    lazy var alertService = DefaultAlertService()
    lazy var noticeService = DefaultNoticeService()
    lazy var authService = DefaultAuthService()
}

extension ModuleFactory: ModuleFactoryInterface {
    
    public func makePostDetailVC() -> Presentation.PostDetailVC {
        let repository = PostDetailRepository(service: alertService)
        let useCase = DefaultPostDetailUseCase(repository: repository)
        let viewModel = PostDetailViewModel(useCase: useCase)
        let PostDetailVC = PostDetailVC()
        PostDetailVC.viewModel = viewModel
        return PostDetailVC
    }
    
    public func makeSettingVC() -> Presentation.SettingVC {
        let repository = SettingRepository(service: alertService)
        let useCase = DefaultSettingUseCase(repository: repository)
        let viewModel = SettingViewModel(useCase: useCase)
        let settingVC = SettingVC()
        settingVC.viewModel = viewModel
        return settingVC
    }
}
