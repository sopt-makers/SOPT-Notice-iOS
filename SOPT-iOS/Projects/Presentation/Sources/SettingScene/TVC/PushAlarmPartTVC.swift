//
//  PushAlarmPartTVC.swift
//  Presentation
//
//  Created by devxsby on 2022/10/20.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit
import DSKit

import SnapKit
import Then

class PushAlarmPartTVC: UITableViewCell {
    
    // MARK: - Properties
    
    enum PartList: CaseIterable {
        case FullNotice, PM, Design, iOS, Android, Server, Web
    }
    
    // MARK: - UI Components
    
    let titleLabel = UILabel().then {
        $0.setTypoStyle(.body1)
        $0.textColor = DSKitAsset.Colors.gray900.color
        $0.textAlignment = .left
    }
    
    lazy var stateButton = UIButton(type: .custom).then {
        $0.setImage(DSKitAsset.Assets.icStateOff.image.withRenderingMode(.alwaysOriginal), for: .normal)
        $0.setImage(DSKitAsset.Assets.icStateOn.image.withRenderingMode(.alwaysOriginal), for: .selected)
        $0.contentMode = .scaleAspectFill
        $0.addTarget(self, action: #selector(stateButtonDidTap), for: .touchUpInside)

    }
    
    private let dividerView = UIView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray200.color
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

extension PushAlarmPartTVC {
    
    private func setUI() {
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        addSubviews(titleLabel, dividerView)
        contentView.addSubview(stateButton)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        stateButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(1)
            make.height.equalTo(1)
        }
    }
    
    @objc private func stateButtonDidTap() {
        print("\(titleLabel.text!) state button did tap")
        stateButton.isSelected.toggle()
    }
}
