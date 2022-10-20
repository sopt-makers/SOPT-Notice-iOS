//
//  SettingViewModel.swift
//  Presentation
//
//  Created by devxsby on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Core
import Domain

public class SettingViewModel {
    
    // MARK: - init
  
    public init() {
        
    }
}

extension SettingViewModel {
    
    func getSettingCellTitle(cellType: SettingTVC.SettingCellType) -> String {
        switch cellType {
        case .pushAlarm:
            return "푸시 알림 설정"
        case .termsOfService:
            return "서비스 이용약관"
        case .privacyPolicy:
            return "개인정보 처리방침"
        }
    }
    
    func setButtonState(cellType: SettingTVC.SettingCellType) -> Bool {
        switch cellType {
        case .pushAlarm:
            return false
        default:
            return true
        }
    }
}
