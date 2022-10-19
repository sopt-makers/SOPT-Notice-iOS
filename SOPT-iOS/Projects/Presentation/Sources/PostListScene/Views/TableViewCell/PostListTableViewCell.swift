//
//  PostListTableViewCell.swift
//  Presentation
//
//  Created by sejin on 2022/10/18.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

import DSKit

class PostListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "31th SOPT OT 공지"
        label.setTypoStyle(.subtitle2)
        label.textColor = DSKitAsset.Colors.gray900.color
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        return label
    }()
    
    private let writerAndDateLabel: UILabel = {
        let label = UILabel()
        label.text = "관리자·22.09.27"
        label.setTypoStyle(.caption)
        label.textColor = DSKitAsset.Colors.gray400.color
        return label
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = DSKitAsset.Colors.gray100.color
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

extension PostListTableViewCell {
    private func setUI() {
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        addSubviews(titleLabel, writerAndDateLabel, dividerView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview()
        }
        
        writerAndDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(writerAndDateLabel.snp.bottom).offset(14)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
