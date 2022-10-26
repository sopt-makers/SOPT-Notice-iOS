//
//  PostDetailViewModel.swift
//  Presentation
//
//  Created by Junho Lee on 2022/10/10.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Core
import Domain

public class PostDetailViewModel: ViewModelType {
    
    private let useCase: PostDetailUseCase
    private var cancelBag = CancelBag()
    
    private let noticeId: Int
    
    // MARK: - Inputs
    
    public struct Input {
        let viewDidLoad: Driver<Void>
        let imageViewTapped: Driver<Void>
    }
    
    // MARK: - Outputs
    
    public class Output {
        @Published var postDetailModel: PostDetailModel?
        @Published var presentImageSlide: [ImageSlideShowImages]?
    }
    
    // MARK: - init
    
    public init(useCase: PostDetailUseCase, noticeId: Int) {
        self.useCase = useCase
        self.noticeId = noticeId
    }
}

extension PostDetailViewModel {
    public func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, cancelBag: cancelBag)
        
        input.viewDidLoad
            .sink {
                self.useCase.fetchPostDetail(noticeId: self.noticeId)
            }.store(in: cancelBag)
        
        input.imageViewTapped
            .sink {
                output.presentImageSlide = self.useCase.imageSlideImages.value
            }.store(in: cancelBag)
        
        return output
    }
    
    private func bindOutput(output: Output, cancelBag: CancelBag) {
        let postDetailModel = self.useCase.postDetailModel
        
        postDetailModel.asDriver()
            .compactMap { $0 }
            .assign(to: \.postDetailModel, on: output)
            .store(in: cancelBag)
    }
}
