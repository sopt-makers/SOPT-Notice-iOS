//
//  AuthPushAlarmVC.swift
//  Presentation
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

import Combine
import SnapKit
import Then

public class AuthPushAlarmVC: UIViewController {
    
    // MARK: - Properties
    
    public var viewModel: AuthPushAlarmViewModel!
    private var cancelBag = Set<AnyCancellable>()
  
    // MARK: - UI Components
  
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModels()
    }
}

// MARK: - Methods

extension AuthPushAlarmVC {
  
    private func bindViewModels() {
        let input = AuthPushAlarmViewModel.Input()
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
    }

}
