//
//  SampleVC.swift
//  Presentation
//
//  Created by 양수빈 on 2022/10/06.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

import SnapKit
import Combine

//public protocol SampleModuleFactory {
//    func makeSampleVC() -> SampleVC
//}

public class SampleVC: UIViewController {
    
    public var factory: ModuleFactoryInterface!
    public var viewModel: SampleViewModel!
    private var cancelBag = Set<AnyCancellable>()
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        self.bindViewModels()
    }
    
    @objc
    func presentSampleVC() {
//        let sampleVC = factory.makeSampleVC()
//        self.present(sampleVC, animated: true)
    }
    
    private func bindViewModels() {
        let input = SampleViewModel.Input()
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
    }

}
