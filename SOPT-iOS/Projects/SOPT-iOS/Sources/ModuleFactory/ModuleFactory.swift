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
    
    public func makeSplashVC() -> Presentation.SplashVC {
        let splashVC = SplashVC()
        splashVC.factory = self
        return splashVC
    }
    
    public func makeAuthSignUpVC() -> Presentation.AuthSignUpVC {
        let repository = AuthSignUpRepository(service: authService)
        let useCase = DefaultAuthSignUpUseCase(repository: repository)
        let viewModel = AuthSignUpViewModel(useCase: useCase)
        let authSignUpVC = AuthSignUpVC()
        authSignUpVC.factory = self
        authSignUpVC.viewModel = viewModel
        return authSignUpVC
    }
    
    public func makeAuthWaitingVC() -> Presentation.AuthWaitingVC {
        let authWaitingVC = AuthWaitingVC()
        authWaitingVC.factory = self
        return authWaitingVC
    }
    
    public func makeAuthCompleteVC() -> Presentation.AuthCompleteVC {
        let authCompleteVC = AuthCompleteVC()
        authCompleteVC.factory = self
        return authCompleteVC
    }
    
    public func makeAuthPushAlarmVC() -> Presentation.AuthPushAlarmVC {
        let repository = AuthPushAlarmRepository(service: authService)
        let useCase = DefaultAuthPushAlarmUseCase(repository: repository)
        let viewModel = AuthPushAlarmViewModel(useCase: useCase)
        let authPushAlarmVC = AuthPushAlarmVC()
        authPushAlarmVC.factory = self
        authPushAlarmVC.viewModel = viewModel
        return authPushAlarmVC
    }
    
    public func makePostListVC() -> Presentation.PostListVC {
        let repository = PostListRepository(service: noticeService)
        let useCase = DefaultPostListUseCase(repository: repository)
        let viewModel = PostListViewModel(useCase: useCase)
        let postListVC = PostListVC()
        postListVC.viewModel = viewModel
        return postListVC
    }
    
    public func makePostDetailVC() -> Presentation.PostDetailVC {
        let repository = PostDetailRepository(service: noticeService)
        repository.fetchPostDetail()
        let useCase = DefaultPostDetailUseCase(repository: repository)
        let viewModel = PostDetailViewModel(useCase: useCase)
        let PostDetailVC = PostDetailVC()
        PostDetailVC.viewModel = viewModel
        return PostDetailVC
    }
    
    public func makeSettingVC() -> Presentation.SettingVC {
        let settingVC = SettingVC()
        let viewModel = SettingViewModel()
        settingVC.factory = self
        settingVC.viewModel = viewModel
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
