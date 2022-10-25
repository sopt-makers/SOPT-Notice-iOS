//
//  AuthWaitingVC.swift
//  Presentation
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit
import DSKit

import SnapKit
import Then

public class AuthWaitingVC: UIViewController {
    
    // MARK: - Properties
    
    public var factory: ModuleFactoryInterface!
  
    // MARK: - UI Components
  
    private let titleLabel = UILabel().then {
        $0.setTypoStyle(.h2)
        let attributedString = NSMutableAttributedString(string: "인증 메일", attributes: [NSAttributedString.Key.foregroundColor: DSKitAsset.Colors.blue500.color])
        attributedString.append(NSAttributedString(string: "을 발송했어요.",
                                                   attributes: [.foregroundColor: DSKitAsset.Colors.gray900.color]))
        $0.attributedText = attributedString
    }
    
    private let subtitleLabel = UILabel().then {
        $0.text = """
                  메일 내에서 ‘회원가입 계속하기' 버튼을 눌러
                  인증 절차를 진행해주세요.
                  """
        $0.textColor = DSKitAsset.Colors.gray500.color
        $0.textAlignment = .left
        $0.setTypoStyle(.body1)
        $0.setLineSpacing(lineSpacing: 8)
        $0.numberOfLines = 2
    }
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setLayout()
    }
}

// MARK: - UI & Layout

extension AuthWaitingVC {
    
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    private func setLayout() {
        self.view.addSubviews(titleLabel, subtitleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(88)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
    }
}
