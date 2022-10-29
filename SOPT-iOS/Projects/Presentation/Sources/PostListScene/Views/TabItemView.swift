//
//  TabItemView.swift
//  Presentation
//
//  Created by sejin on 2022/10/18.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

import DSKit

final class TabItemView: UIView {
    
    // MARK: - Properties
    
    private let title: String

    // MARK: - UI Components
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setTypoStyle(.body2)
        label.textColor = DSKitAsset.Colors.gray400.color
        label.text = title
        return label
    }()
    
    private lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = DSKitAsset.Colors.blue500.color
        return view
    }()
    
    // MARK: - Initialization
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        
        self.setUI()
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }

    // MARK: - UI & Layout
    
    private func setUI() {
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        self.addSubviews(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - TabItemProtocol

extension TabItemView: TabItemProtocol {
    
    func onSelected() {
        self.titleLabel.textColor = DSKitAsset.Colors.gray900.color
        
        if borderView.superview == nil {
            self.addSubview(borderView)
            
            borderView.snp.makeConstraints { make in
                make.leading.bottom.trailing.equalToSuperview()
                make.height.equalTo(3)
            }
        }
    }
    
    func onNotSelected() {
        self.titleLabel.textColor =  DSKitAsset.Colors.gray400.color

        self.layer.shadowOpacity = 0
        
        self.borderView.removeFromSuperview()
    }
}
