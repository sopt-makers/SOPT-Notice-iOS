//
//  SearchHeaderView.swift
//  Presentation
//
//  Created by 양수빈 on 2022/10/22.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

import SnapKit

import Core
import DSKit

class SearchHeaderView: UITableViewHeaderFooterView, UITableViewHeaderFooterRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let countLabel = UILabel()
    private let bottomLineView = UIView()
    
    // MARK: - Initialization
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setUI()
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Methods

extension SearchHeaderView {
    func initCell(_ count: Int) {
        countLabel.text = "\(count)" + I18N.Search.countUnit
    }
    
    private func setUI() {
        self.backgroundColor = .white
        
        bottomLineView.backgroundColor = DSKitAsset.Colors.gray300.color
        
        countLabel.setTypoStyle(.body2)
        countLabel.textColor = DSKitAsset.Colors.gray900.color
    }
    
    private func setLayout() {
        self.addSubviews(bottomLineView, countLabel)
        
        bottomLineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(4)
            make.height.equalTo(1)
        }
        
        countLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.bottom.equalTo(bottomLineView.snp.bottom).inset(5)
        }
    }
}

