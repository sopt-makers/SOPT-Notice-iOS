//
//  PushAlarmSettingViewModel.swift
//  Presentation
//
//  Created by devxsby on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Core
import Domain
import Network

extension PartCategory {
    public static var allCases: [PartCategory] = [.fullNotice, .plan, .design, .ios, .android, .web, .server]
    
    var title: String {
        switch self {
        case .fullNotice:
            return "전체 공지"
        case .plan:
            return "기획"
        case .design:
            return "디자인"
        case .ios:
            return "iOS"
        case .android:
            return "Android"
        case .web:
            return "Web"
        case .server:
            return "Server"
        }
    }
}

public class PushAlarmSettingViewModel: ViewModelType {

    // MARK: - Properties

//    enum PartList: CaseIterable {
//        case FullNotice, PM, Design, iOS, Android, Server, Web
//
//        var title: String {
//            switch self {
//            case .FullNotice:
//                return "전체 공지"
//            case .PM:
//                return "기획"
//            case .Design:
//                return "디자인"
//            case .iOS:
//                return "iOS"
//            case .Android:
//                return "Android"
//            case .Server:
//                return "Server"
//            case .Web:
//                return "Web"
//            }
//        }
//    }
    
    private let useCase: PushAlarmSettingUseCase
    private var cancelBag = CancelBag()
  
    // MARK: - Inputs
    
    public struct Input {
        let viewDidLoad: Driver<Void>
    }
    
    // MARK: - Outputs
    
    public class Output {
        @Published var pushSettingList: PushAlarmSettingModel?
    }
    
    // MARK: - init
  
    public init(useCase: PushAlarmSettingUseCase) {
        self.useCase = useCase
    }
}

// MARK: - Extensions

extension PushAlarmSettingViewModel {
    public func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, cancelBag: cancelBag)
        
        input.viewDidLoad
            .sink {
                self.useCase.fetchPushSetting()
            }.store(in: cancelBag)
    
        return output
    }
  
    private func bindOutput(output: Output, cancelBag: CancelBag) {
        let pushSetting = self.useCase.pushSetting
        
        pushSetting.asDriver()
            .compactMap { $0 }
            .assign(to: \.pushSettingList, on: output)
            .store(in: cancelBag)
    }
}

extension PushAlarmSettingViewModel {
    func getPartListCount() -> Int {
        return PartCategory.allCases.count
    }
}
