//
//  AuthPushAlarmTVC.swift
//  Presentation
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit
import DSKit

class AuthPushAlarmTVC: UITableViewCell {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    let titleLabel = UILabel().then {
        $0.setTypoStyle(.body1)
        $0.textColor = DSKitAsset.Colors.gray800.color
        $0.textAlignment = .left
    }
    
    lazy var stateButton = UIButton(type: .custom).then {
        $0.setImage(DSKitAsset.Assets.icAlarmOff.image.withRenderingMode(.alwaysOriginal), for: .normal)
        $0.setImage(DSKitAsset.Assets.icAlarmOn.image.withRenderingMode(.alwaysOriginal), for: .selected)
        $0.contentMode = .scaleAspectFill
        $0.addTarget(self, action: #selector(stateButtonDidTap), for: .touchUpInside)
    }
    
    let horizontalLine = UIView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray100.color
    }
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUI()
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension AuthPushAlarmTVC {
    
    func initCell(_ indexPath: Int) {
        horizontalLine.isHidden = (indexPath != 0)
    }
    
    private func setUI() {
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        addSubviews(titleLabel, horizontalLine)
        contentView.addSubview(stateButton)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        stateButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        horizontalLine.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
    }
    
    @objc private func stateButtonDidTap() {
        print("\(titleLabel.text!) state button did tap")
        stateButton.isSelected.toggle()
    }
}
