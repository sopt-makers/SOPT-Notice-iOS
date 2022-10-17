//
//  SettingVC.swift
//  Presentation
//
//  Created by devxsby on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

import Combine
import SnapKit
import Then

public class SettingVC: UIViewController {
    
    // MARK: - Properties
    
    public var viewModel: SettingViewModel!
    private var cancelBag = Set<AnyCancellable>()
  
    // MARK: - UI Components
  
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModels()
    }
}

// MARK: - Methods

extension SettingVC {
  
    private func bindViewModels() {
        let input = SettingViewModel.Input()
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
    }

}
