//
//  PostListVC.swift
//  Presentation
//
//  Created by sejin on 2022/10/18.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

import Combine
import SnapKit
import Then

public class PostListVC: UIViewController {
    
    // MARK: - Properties
    
    public var viewModel: PostListViewModel!
    private var cancelBag = Set<AnyCancellable>()
    let partList = ["전체", "기획", "디자인", "iOS", "Android", "Server", "Web"]
  
    // MARK: - UI Components
    
    private lazy var postListViewPager: ViewPager = {
        let viewPager = ViewPager(tabSizeConfiguration: .fixed(width: 72, height: 32))
        
        let tabs = partList.map { TabItemView(title: $0) }
        let pages = partList.map { _ in
            let view = UIView()
            view.backgroundColor = .white
            return view
        }
 
        viewPager.tabbedView.tabs = tabs
        
        viewPager.pagedView.pages = pages
        
        return viewPager
    }()
  
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModels()
        self.setUI()
        self.setLayout()
    }
}

// MARK: - UI & Layout

extension PostListVC {
    
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    private func setLayout() {
        self.view.addSubviews(postListViewPager)
        postListViewPager.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Methods

extension PostListVC {
  
    private func bindViewModels() {
        let input = PostListViewModel.Input()
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
    }

}
