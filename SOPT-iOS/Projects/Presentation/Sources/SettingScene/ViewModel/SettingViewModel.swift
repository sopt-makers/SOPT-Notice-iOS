//
//  SettingViewModel.swift
//  Presentation
//
//  Created by devxsby on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Core
import Domain

public class SettingViewModel: ViewModelType {

    private let useCase: SettingUseCase
    private var cancelBag = Set<AnyCancellable>()
  
    // MARK: - Inputs
    
    public struct Input {
    
    }
    
    // MARK: - Outputs
    
    public struct Output {
    
    }
    
    // MARK: - init
  
    public init(useCase: SettingUseCase) {
        self.useCase = useCase
    }
}

extension SettingViewModel {
    public func transform(from input: Input, cancelBag: Set<AnyCancellable>) -> Output {
        let output = Output()
        self.bindOutput(output: output, cancelBag: cancelBag)
        // input,output 상관관계 작성
    
        return output
    }
  
    private func bindOutput(output: Output, cancelBag: Set<AnyCancellable>) {
    
    }
}