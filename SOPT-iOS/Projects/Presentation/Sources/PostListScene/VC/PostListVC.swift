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

import DSKit

public class PostListVC: UIViewController {
    
    // MARK: - Properties
    
    public var viewModel: PostListViewModel!
    private var cancelBag = Set<AnyCancellable>()
    let partList = ["전체", "기획", "디자인", "iOS", "Android", "Server", "Web"]
  
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .leftTitle).setTitle("공지")
        .rightButtonAction {
            print("rightButtonAction")
        }
        .otherRightButtonAction {
            self.setSearchView(false)
        }
    private let searchView = UIView()
    private let searchButton = UIButton()
    private let searchTextField = UITextField()
    private let bottomLineView = UIView()
    private let cancelButton = UIButton()
    
    private lazy var postListViewPager: ViewPager = {
        let viewPager = ViewPager(tabSizeConfiguration: .fixed(width: 72, height: 32))
        
        let tabs = partList.map { TabItemView(title: $0) }
        let pages = partList.map { _ in PostListPageView() }
 
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
        self.setAddTarget()
    }
}

// MARK: - UI & Layout

extension PostListVC {
    
    private func setUI() {
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        
        self.searchView.alpha = 0
        searchButton.setImage(UIImage(asset: DSKitAsset.Assets.icSearch), for: .normal)
        bottomLineView.backgroundColor = DSKitAsset.Colors.gray900.color
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.titleLabel?.setTypoStyle(.body1)
        cancelButton.setTitleColor(DSKitAsset.Colors.gray900.color, for: .normal)
        searchTextField.placeholder = "검색어 입력"
    }
    
    private func setLayout() {
        self.view.addSubviews(naviBar, searchView, postListViewPager)
        
        naviBar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        searchView.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(56)
        }
        
        postListViewPager.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        searchView.addSubviews(searchButton, searchTextField, bottomLineView, cancelButton)
        
        searchButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(40)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(searchButton.snp.trailing)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(cancelButton.snp.leading)
        }
        
        bottomLineView.snp.makeConstraints { make in
            make.leading.equalTo(searchTextField.snp.leading)
            make.trailing.equalTo(searchTextField.snp.trailing)
            make.bottom.equalToSuperview().inset(13)
            make.height.equalTo(1)
        }
    }
}

// MARK: - Methods

extension PostListVC {
  
    private func bindViewModels() {
        let input = PostListViewModel.Input()
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
    }
    
    private func setDelegate() {
        searchTextField.delegate = self
    }
    
    private func setAddTarget() {
        cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
    }
    
    private func setSearchView(_ isHidden: Bool) {
        self.naviBar.hideNaviBar(!isHidden)
        UIView.animate(withDuration: 0.3,
                       delay: 0.6,
                       options: .curveEaseInOut) {
            self.searchView.alpha = !isHidden ? 0 : 1
        } completion: { _ in
            if isHidden {
                self.searchView.alpha = 0
                self.view.endEditing(true)
            } else {
                self.searchView.alpha = 1
                self.searchTextField.becomeFirstResponder()
            }
        }
    }
}

// MARK: - @objc

extension PostListVC {
    @objc
    private func tappedCancelButton() {
        setSearchView(true)
    }
}

extension PostListVC: UITextFieldDelegate {
    
}
