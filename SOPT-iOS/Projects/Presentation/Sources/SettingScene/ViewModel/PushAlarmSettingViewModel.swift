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

public class PushAlarmSettingViewModel: ViewModelType {

    // MARK: - Properties

    private let useCase: PushAlarmSettingUseCase
    private var cancelBag = CancelBag()
    private var pushToggleList = [Bool]()
  
    // MARK: - Inputs
    
    public struct Input {
        let viewDidLoad: Driver<Void>
        let confirmButtonTapped: Driver<Void>
        let pushToggleList: Published<[Bool]>.Publisher
    }
    
    // MARK: - Outputs
    
    public class Output {
        @Published var pushSettingList: PushAlarmSettingModel?
        @Published var editSettingStatusCode: Int?
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
        
        input.confirmButtonTapped
            .sink {
                self.useCase.editPushSetting(toggleList: self.pushToggleList)
            }.store(in: cancelBag)
        
        input.pushToggleList
            .sink {
                self.pushToggleList = $0
            }.store(in: cancelBag)
    
        return output
    }
  
    private func bindOutput(output: Output, cancelBag: CancelBag) {
        let pushSetting = self.useCase.pushSetting
        let editSettingStatusCode = self.useCase.editSettingStatusCode
        
        pushSetting.asDriver()
            .compactMap { $0 }
            .assign(to: \.pushSettingList, on: output)
            .store(in: cancelBag)
        
        editSettingStatusCode.asDriver()
            .compactMap { $0 }
            .assign(to: \.editSettingStatusCode, on: output)
            .store(in: cancelBag)
    }
}

extension PushAlarmSettingViewModel {
    func getPartListCount() -> Int {
        return PartCategory.allCases.count
    }
}
