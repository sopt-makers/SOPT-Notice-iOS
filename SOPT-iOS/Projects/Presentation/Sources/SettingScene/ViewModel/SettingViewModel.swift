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
    
    // MARK: - Properties
    
    enum SettingCellType: CaseIterable {
        case pushAlarm, termsOfService, privacyPolicy
        
        var title: String {
            switch self {
            case .pushAlarm:
                return "푸시 알림 설정"
            case .termsOfService:
                return "서비스 이용약관"
            case .privacyPolicy:
                return "개인정보 처리방침"
            }
        }
    }
    
    // MARK: - init
  
    public init() {
    }
}

extension SettingViewModel {
    
    func getSettingCellCount() -> Int {
        return SettingCellType.allCases.count
    }
    
    func getSettingCellTitle(cellType: SettingCellType) -> String {
        return cellType.title
    }
    
    func setButtonState(cellType: SettingCellType) -> Bool {
        switch cellType {
        case .pushAlarm:
            return false
        default:
            return true
        }
    }
}
