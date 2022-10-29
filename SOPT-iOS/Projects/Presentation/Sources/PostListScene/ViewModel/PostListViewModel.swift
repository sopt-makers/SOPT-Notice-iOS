//
//  PostListViewModel.swift
//  Presentation
//
//  Created by sejin on 2022/10/18.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Core
import Domain

public class PostListViewModel: ViewModelType {
    
    var partIndex: Int = 0
    private let useCase: PostListUseCase
    private var cancelBag = CancelBag()
  
    // MARK: - Inputs
    
    public struct Input {
        let selectedPartIndex: AnyPublisher<Int, Error>
        let textChanged: AnyPublisher<String?, Error>
    }
    
    // MARK: - Outputs
    
    public struct Output {
        var postList = PassthroughSubject<[PostListModel], Error>()
        var searchList = PassthroughSubject<[PostListModel], Error>()
    }
    
    // MARK: - init
  
    public init(useCase: PostListUseCase) {
        self.useCase = useCase
    }
}

extension PostListViewModel {
    public func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, cancelBag: cancelBag)
        
        input.selectedPartIndex
            .sink(receiveCompletion: { event in
                print("PostListViewModel - completion: \(event)")
            }, receiveValue: { [weak self] idx in
                guard let self = self else { return }
                self.partIndex = idx
                self.useCase.getPostList(partName: PartCategory.allCases[idx].upperCasedTitle)
            })
            .store(in: cancelBag)
        
        input.textChanged
            .filter { $0 != nil && $0 != ""}
            .sink(receiveCompletion: { event in
                print("PostListViewModel - completion: \(event)")
            }, receiveValue: { [weak self] str in
                guard let self = self else { return }
                self.useCase.getSearch(query: str!)
            })
            .store(in: cancelBag)
    
        return output
    }
  
    private func bindOutput(output: Output, cancelBag: CancelBag) {
        let postListResult = useCase.postList
        let searchResult = useCase.searchList
        
        postListResult.sink(receiveCompletion: { event in
            print("PostListViewModel - completion: \(event)")
        }, receiveValue: { value in
            output.postList.send(value)
        })
        .store(in: cancelBag)
        
        searchResult.sink(receiveCompletion: { event in
            print("PostListViewModel - completion: \(event)")
        }, receiveValue: { value in
            output.searchList.send(value)
        })
        .store(in: cancelBag)
    }
}
