//
//  ViewPager.swift
//  Presentation
//
//  Created by sejin on 2022/10/18.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit
import Combine

import DSKit

class ViewPager: UIView {
    
    // MARK: - Properties
    
    private var cancelBag: Set<AnyCancellable> = []
    
    public let sizeConfiguration: TabbedView.SizeConfiguration
    
    // MARK: - UI Components
    
    public lazy var tabbedView: TabbedView = {
        let tabbedView = TabbedView(
            sizeConfiguration: sizeConfiguration
        )
        return tabbedView
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = DSKitAsset.Colors.gray300.color
        return view
    }()
    
    public let pagedView = PagedView()
    
    // MARK: - Initialization
    
    init(tabSizeConfiguration: TabbedView.SizeConfiguration) {
        self.sizeConfiguration = tabSizeConfiguration
        super.init(frame: .zero)
        
        self.setLayout()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setLayout() {
        self.addSubviews(tabbedView, dividerView, pagedView)
        
        tabbedView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(sizeConfiguration.height)
        }
        
        self.sendSubviewToBack(dividerView)
        dividerView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(tabbedView.snp.bottom).inset(1)
            make.leading.trailing.equalToSuperview()
        }
        
        pagedView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            make.top.equalTo(tabbedView.snp.bottom)
        }
    }
}

// MARK: - Bind

extension ViewPager {
    
    private func bind() {
        tabbedView.selectedTabIndex.sink {
            self.pagedView.moveToPage(at: $0)
        }.store(in: &self.cancelBag)
    }
}
