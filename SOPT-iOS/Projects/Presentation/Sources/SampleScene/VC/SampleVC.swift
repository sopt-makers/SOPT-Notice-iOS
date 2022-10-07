//
//  SampleVC.swift
//  Presentation
//
//  Created by 양수빈 on 2022/10/06.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

import Combine

//public protocol SampleModuleFactory {
//    func makeSampleVC() -> SampleVC
//}

public class SampleVC: UIViewController {
    
    public var viewModel: SampleViewModel!
    private var cancelBag = Set<AnyCancellable>()
    public var factory: ModuleFactoryInterface!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        self.bindViewModels()
    }
    
    private func bindViewModels() {
        let input = SampleViewModel.Input()
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
    }

}
