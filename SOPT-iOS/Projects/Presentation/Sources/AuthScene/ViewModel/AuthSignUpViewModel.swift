//
//  AuthSignUpViewModel.swift
//  Presentation
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Combine

import Core
import Domain

public class AuthSignUpViewModel: ViewModelType {

    private let useCase: AuthSignUpUseCase
    private var cancelBag = CancelBag()
    private var emailText = ""
  
    // MARK: - Inputs
    
    public struct Input {
        let verifyButtonTapped: Driver<Void>
        let textChanged: PassthroughSubject<String?, Error>
    }
    
    // MARK: - Outputs
    
    public struct Output {
        var isValidUser = PassthroughSubject<Bool, Error>()
        var message = PassthroughSubject<String?, Error>()
    }
    
    // MARK: - init
  
    public init(useCase: AuthSignUpUseCase) {
        self.useCase = useCase
    }
}

extension AuthSignUpViewModel {
    public func transform(from input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        self.bindOutput(output: output, cancelBag: cancelBag)
        
        input.verifyButtonTapped
            .sink(receiveValue: { () in
                self.useCase.postAuthEmail(email: self.emailText)
            }).store(in: self.cancelBag)
        
        input.textChanged
            .compactMap { $0 }
            .sink { event in
                print("AuthSignUpViewModel - completion: \(event)")
            } receiveValue: { value in
                self.emailText = value
            }.store(in: self.cancelBag)
        
        return output
    }
  
    private func bindOutput(output: Output, cancelBag: CancelBag) {
        useCase.authSignUpModel.sink { event in
            print("AuthSignUpViewModel - completion: \(event)")
        } receiveValue: { value in
            if let _ = value.userId {
                output.isValidUser.send(true)
            } else {
                output.isValidUser.send(false)
                output.message.send(value.message)
            }
        }.store(in: self.cancelBag)
    }
}
