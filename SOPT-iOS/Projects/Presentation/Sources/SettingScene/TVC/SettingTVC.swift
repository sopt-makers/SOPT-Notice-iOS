//
//  SettingTVC.swift
//  Presentation
//
//  Created by devxsby on 2022/10/19.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit
import DSKit

import SnapKit
import Then

class SettingTVC: UITableViewCell {
    
    // MARK: - Properties
    
    enum SettingCellType: CaseIterable {
        case pushAlarm, termsOfService, privacyPolicy
    }
    
    // MARK: - UI Components
    
    let titleLabel = UILabel().then {
        $0.setTypoStyle(.body1)
        $0.textColor = DSKitAsset.Colors.gray900.color
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
        $0.textAlignment = .left
    }
    
    lazy var detailVCButton = UIButton(type: .system).then {
        $0.setImage(DSKitAsset.Assets.icRight.image, for: .normal)
        $0.tintColor = DSKitAsset.Colors.black.color
        $0.addTarget(self, action: #selector(goToDetailVC), for: .touchUpInside)
    }
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = DSKitAsset.Colors.gray200.color
        return view
    }()
    
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

extension SettingTVC {
    
    private func setUI() {
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        addSubviews(titleLabel, dividerView)
        contentView.addSubview(detailVCButton)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        detailVCButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(22)
            make.centerY.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(1)
            make.height.equalTo(1)
        }
    }
    
    @objc private func goToDetailVC() {
        print("goToDetailVC")
    }
}
