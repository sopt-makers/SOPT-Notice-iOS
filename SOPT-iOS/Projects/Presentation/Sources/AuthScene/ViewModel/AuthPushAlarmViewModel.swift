//
//  AuthPushAlarmViewModel.swift
//  Presentation
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Core
import Domain

public class AuthPushAlarmViewModel: ViewModelType {
    
    // MARK: - Properties

    enum PartList: CaseIterable {
        case FullNotice, PM, Design, iOS, Android, Server, Web
        
        var title: String {
            switch self {
            case .FullNotice:
                return "SOPT 전체 공지"
            case .PM:
                return "기획"
            case .Design:
                return "디자인"
            case .iOS:
                return "iOS"
            case .Android:
                return "Android"
            case .Server:
                return "Server"
            case .Web:
                return "Web"
            }
        }
    }

    private let useCase: AuthPushAlarmUseCase
    private var cancelBag = Set<AnyCancellable>()
  
    // MARK: - Inputs
    
    public struct Input {
    
    }
    
    // MARK: - Outputs
    
    public struct Output {
    
    }
    
    // MARK: - init
  
    public init(useCase: AuthPushAlarmUseCase) {
        self.useCase = useCase
    }
}

// MARK: - Extensions

extension AuthPushAlarmViewModel {
    public func transform(from input: Input, cancelBag: Set<AnyCancellable>) -> Output {
        let output = Output()
        self.bindOutput(output: output, cancelBag: cancelBag)
        // input,output 상관관계 작성
    
        return output
    }
  
    private func bindOutput(output: Output, cancelBag: Set<AnyCancellable>) {
    
    }
}


// MARK: - Extensions

extension AuthPushAlarmViewModel {
    
    func getPartListCount() -> Int {
        return PartList.allCases.count
    }
}
