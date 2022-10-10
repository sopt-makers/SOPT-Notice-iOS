//
//  PostDetailVC.swift
//  Presentation
//
//  Created by Junho Lee on 2022/10/10.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

import Combine
import SnapKit
import Then

public class PostDetailVC: UIViewController {
    
    // MARK: - Properties
    
    public var viewModel: PostDetailViewModel!
    private var cancelBag = Set<AnyCancellable>()
  
    // MARK: - UI Components
  
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModels()
    }
}

// MARK: - Methods

extension PostDetailVC {
  
    private func bindViewModels() {
        let input = PostDetailViewModel.Input()
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
    }

}
