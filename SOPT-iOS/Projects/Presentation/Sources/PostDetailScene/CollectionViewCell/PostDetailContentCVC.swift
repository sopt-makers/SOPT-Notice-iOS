//
//  PostDetailContent.swift
//  Presentation
//
//  Created by Junho Lee on 2022/10/10.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

import Core
import Domain
import DSKit

import SnapKit

final class PostDetailContentCVC: UICollectionViewCell, UICollectionViewRegisterable {
    
    // MARK: - Properties
    
    static var isFromNib: Bool = false
    
    // MARK: - UI Components
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.setTypoStyle(.body2)
        label.textColor = DSKitAsset.Colors.gray900.color
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
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

extension PostDetailContentCVC {
    
    private func setUI() {
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        self.addSubview(contentLabel)
        
        contentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func setData(model: PostDetailModel.Content) {
        self.contentLabel.text = model.content
    }
}
