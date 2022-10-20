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
    public func makePostListVC() -> Presentation.PostListVC {
        let repository = PostListRepository(service: alertService)
        let useCase = DefaultPostListUseCase(repository: repository)
        let viewModel = PostListViewModel(useCase: useCase)
        let postListVC = PostListVC()
        postListVC.viewModel = viewModel
        return postListVC
    }
    
    public func makePostDetailVC() -> Presentation.PostDetailVC {
        let repository = PostDetailRepository(service: alertService)
        let useCase = DefaultPostDetailUseCase(repository: repository)
        let viewModel = PostDetailViewModel(useCase: useCase)
        let PostDetailVC = PostDetailVC()
        PostDetailVC.viewModel = viewModel
        return PostDetailVC
    }
    
    public func makeSettingVC() -> Presentation.SettingVC {
        let settingVC = SettingVC()
        settingVC.factory = self
        return settingVC
    }
    
    public func makePushAlarmSettingVC() -> Presentation.PushAlarmSettingVC {
        let repository = PushAlarmSettingRepository(service: alertService)
        let useCase = DefaultPushAlarmSettingUseCase(repository: repository)
        let viewModel = PushAlarmSettingViewModel(useCase: useCase)
        let pushAlarmSettingVC = PushAlarmSettingVC()
        pushAlarmSettingVC.viewModel = viewModel
        return pushAlarmSettingVC
    }
}
