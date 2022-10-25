//
//  AuthCompleteVC.swift
//  Presentation
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit
import DSKit

import SnapKit
import Then

public class AuthCompleteVC: UIViewController {
    
    // MARK: - Properties
    
    public var factory: ModuleFactoryInterface!
  
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.setTypoStyle(.h2)
        let attributedString = NSMutableAttributedString(string: "인증", attributes: [NSAttributedString.Key.foregroundColor: DSKitAsset.Colors.blue500.color])
        attributedString.append(NSAttributedString(string: "이 완료되었어요.",
                                                   attributes: [.foregroundColor: DSKitAsset.Colors.gray900.color]))
        $0.attributedText = attributedString
    }
    
    private lazy var startButton = UIButton(type: .system).then {
        $0.setTitle("SOPT 앱 시작하기", for: .normal)
        $0.setTitleColor(DSKitAsset.Colors.white.color, for: .normal)
        $0.backgroundColor = DSKitAsset.Colors.blue500.color
        $0.titleLabel!.setTypoStyle(.body2)
        $0.contentHorizontalAlignment = .center
        $0.layer.cornerRadius = 22
        $0.addTarget(self, action: #selector(startButtonDidTap), for: .touchUpInside)
    }
  
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setLayout()
    }
}

// MARK: - UI & Layout

extension AuthCompleteVC {
    
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    private func setLayout() {
        self.view.addSubviews(titleLabel, startButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(88)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.width.equalTo(166)
            make.height.equalTo(44)
        }
    }
}

// MARK: - Methods

extension AuthCompleteVC {
    
    @objc private func startButtonDidTap() {
        print("start Button Did Tap")
    }
}
