//
//  AuthSignUpVC.swift
//  Presentation
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

import Combine
import SnapKit
import Then

public class AuthSignUpVC: UIViewController {
    
    // MARK: - Properties
    
    public var viewModel: AuthSignUpViewModel!
    private var cancelBag = Set<AnyCancellable>()
  
    // MARK: - UI Components
  
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModels()
    }
}

// MARK: - Methods

extension AuthSignUpVC {
  
    private func bindViewModels() {
        let input = AuthSignUpViewModel.Input()
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
    }

}
