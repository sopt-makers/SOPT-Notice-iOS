//
//  PostDetailTitle.swift
//  Presentation
//
//  Created by Junho Lee on 2022/10/10.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

import Core

import SnapKit

final class PostDetailTitleCVC: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let topDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.208, green: 0.212, blue: 0.216, alpha: 1)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목입니다"
        label.sizeToFit()
        label.font = .systemFont(ofSize: 18)
        label.textColor = UIColor(red: 0.082, green: 0.086, blue: 0.09, alpha: 1)
        label.numberOfLines = 2
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let writerAndDateLabel: UILabel = {
        let label = UILabel()
        label.text = "관리자·22.09.27"
        label.sizeToFit()
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.682, green: 0.686, blue: 0.69, alpha: 1)
        return label
    }()
    
    private let bottomDivdierView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.894, green: 0.898, blue: 0.902, alpha: 1)
        return view
    }()
    
    // MARK: - View Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostDetailTitleCVC {
    
    private func setUI() {
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        self.addSubviews(topDividerView, titleLabel, writerAndDateLabel,
                         bottomDivdierView)
        
        topDividerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topDividerView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
        
        writerAndDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
        }
        
        bottomDivdierView.snp.makeConstraints { make in
            make.top.equalTo(writerAndDateLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }
}
