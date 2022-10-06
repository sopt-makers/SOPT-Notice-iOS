//
//  SampleViewModel.swift
//  Presentation
//
//  Created by 양수빈 on 2022/10/06.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine
import Core
import Domain

open class SampleViewModel: ViewModelType {

    private let useCase: SampleUseCase
    private let cancelBag = Set<AnyCancellable>()

    // MARK: - Inputs
    public struct Input {

    }

    // MARK: - Outputs
    public struct Output {

    }

    public init(useCase: SampleUseCase) {
        self.useCase = useCase
    }
}

extension SampleViewModel {
    public func transform(from input: Input) -> Output {
        let output = Output()
        self.bindOutput(output: output)
        // input,output 상관관계 작성

        return output
    }

    private func bindOutput(output: Output) {

    }
}
