//
//  AuthSignUpVC.swift
//  Presentation
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit
import DSKit

import Combine
import SnapKit
import Then

public class AuthSignUpVC: UIViewController {
        
    // MARK: - Properties
    public var factory: ModuleFactoryInterface!
    public var viewModel: AuthSignUpViewModel!
    private var cancelBag = Set<AnyCancellable>()
  
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .onlyRightButton)
           .setRightButtonTitle("인증하기")
    
    private let titleLabel = UILabel().then {
        $0.setTypoStyle(.h2)
        let attributedString = NSMutableAttributedString(string: "이메일", attributes: [NSAttributedString.Key.foregroundColor: DSKitAsset.Colors.blue500.color])
        attributedString.append(NSAttributedString(string: "을 입력해 주세요.",
                                                   attributes: [.foregroundColor: DSKitAsset.Colors.gray900.color]))
        $0.attributedText = attributedString
    }
    
    private let subtitleLabel = UILabel().then {
        $0.text = """
                  SOPT 지원 시 사용했던 이메일을 입력하면
                  회원인증을 할 수 있어요.
                  """
        $0.textColor = DSKitAsset.Colors.gray500.color
        $0.textAlignment = .left
        $0.setTypoStyle(.body1)
        $0.numberOfLines = 2
    }
    
    private lazy var guestButton = UIButton(type: .system).then {
        $0.setTitle("SOPT 회원이 아니에요 >", for: .normal)
        $0.setTitleColor(DSKitAsset.Colors.gray400.color, for: .normal)
        $0.titleLabel!.setTypoStyle(.caption)
        $0.contentHorizontalAlignment = .left
        $0.addTarget(self, action: #selector(guestButtonDidTap), for: .touchUpInside)
    }
    
    private let emailTextField = UITextField().then {
        $0.font = .body1
        $0.tintColor = DSKitAsset.Colors.gray900.color
        $0.attributedPlaceholder = NSAttributedString(string: "이메일 입력", attributes: [NSAttributedString.Key.foregroundColor: DSKitAsset.Colors.gray300.color])
        $0.keyboardType = .emailAddress
        $0.clearButtonMode = .whileEditing
    }
    
    private let verticalLine = UIView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray500.color
    }
    
    private let captionLabel = UILabel().then {
        $0.text = "등록되지 않은 메일입니다."
        $0.textColor = DSKitAsset.Colors.error.color
        $0.setTypoStyle(.caption)
    }
  
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModels()
        self.setUI()
        self.setLayout()
    }
}

// MARK: - UI & Layout

extension AuthSignUpVC {
    
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    private func setLayout() {
        self.view.addSubviews(naviBar, titleLabel, subtitleLabel, guestButton, emailTextField, verticalLine, captionLabel)
        
        naviBar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom).offset(32)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        guestButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(120)
            make.height.equalTo(16)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(guestButton.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
        
        verticalLine.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
        
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(verticalLine.snp.bottom).offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}

// MARK: - Methods

extension AuthSignUpVC {
  
    private func bindViewModels() {
        let input = AuthSignUpViewModel.Input()
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
    }
    
    @objc private func guestButtonDidTap() {
        print("guest Button Did Tap")
    }
}
