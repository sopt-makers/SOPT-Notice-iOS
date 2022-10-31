//
//  TabCollectionViewCell.swift
//  Presentation
//
//  Created by sejin on 2022/10/18.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

protocol TabItemProtocol: UIView {
    func onSelected()
    func onNotSelected()
}

final class TabCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    public var view: TabItemProtocol? {
        didSet {
            self.setLayout()
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        self.contentView.backgroundColor = .clear
    }
    
    private func setLayout() {
        guard let view = view else { return }
        
        self.contentView.addSubview(view)

        view.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
