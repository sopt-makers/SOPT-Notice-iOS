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

import Core
import DSKit
import Domain

public class PostListVC: UIViewController {
    
    // MARK: - Properties
    
    public var viewModel: PostListViewModel!
    private var cancelBag = Set<AnyCancellable>()
    private var textChanged = PassthroughSubject<String?, Error>()
    
    public var factory: ModuleFactoryInterface!
    
    private var searchResultList: [PostListModel] = []
    let partList = ["전체", "기획", "디자인", "iOS", "Android", "Server", "Web"]
    
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .leftTitle)
        .setTitle(I18N.Navi.post)
        .rightButtonAction {
            print("rightButtonAction")
        }
        .otherRightButtonAction {
            self.hideSearchView(false)
        }
    
    private let searchView = UIView()
    private let searchButton = UIButton()
    private let searchTextField = UITextField()
    private let bottomLineView = UIView()
    private let cancelButton = UIButton()
    private let searchImageView = UIImageView()
    private let searchEmptyLabel = UILabel()
    private var diffableDataSource: UITableViewDiffableDataSource<Int, PostListModel>?
    
    private lazy var searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
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
        self.setUI()
        self.setLayout()
        self.setSearchLayout()
        self.setAddTarget()
        self.setRegister()
        self.setDelegate()
        self.setTableView()
        self.bindViewModels()
    }
}

// MARK: - UI & Layout

extension PostListVC {
    
    private func setUI() {
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        
        [self.searchView, self.searchTableView, self.searchImageView, self.searchEmptyLabel].forEach { $0.alpha = 0 }
        
        searchButton.setImage(UIImage(asset: DSKitAsset.Assets.icSearch), for: .normal)
        searchImageView.image = UIImage(asset: DSKitAsset.Assets.icInfo)
        
        searchTextField.attributedPlaceholder = NSAttributedString(string: I18N.Search.placeholder, attributes: [NSAttributedString.Key.foregroundColor : DSKitAsset.Colors.gray300.color, NSAttributedString.Key.font : UIFont.body1])
        searchTextField.textColor = DSKitAsset.Colors.gray900.color
        searchTextField.font = .body1
        
        searchEmptyLabel.text = I18N.Search.enterSearch
        searchEmptyLabel.setTypoStyle(.body2)
        searchEmptyLabel.textColor = DSKitAsset.Colors.gray500.color
        
        bottomLineView.backgroundColor = DSKitAsset.Colors.gray900.color
        
        cancelButton.setTitle(I18N.Search.cancel, for: .normal)
        cancelButton.titleLabel?.setTypoStyle(.body1)
        cancelButton.setTitleColor(DSKitAsset.Colors.gray900.color, for: .normal)
    }
    
    private func setLayout() {
        self.view.addSubviews(naviBar, postListViewPager)
        
        naviBar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        postListViewPager.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setSearchLayout() {
        self.view.addSubviews(searchView, searchTableView,
                              searchEmptyLabel, searchImageView)
        
        searchView.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(56)
        }
        
        searchTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchView.snp.bottom)
        }
        
        searchEmptyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-110)
        }
        
        searchImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(searchEmptyLabel.snp.top).offset(-8)
            make.width.height.equalTo(24)
        }
        
        searchView.addSubviews(searchButton, searchTextField,
                               bottomLineView, cancelButton)
        
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
        let input = PostListViewModel.Input(textChanged: textChanged.eraseToAnyPublisher())
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
        
        output.searchList
            .sink(receiveCompletion: { event in
                print("event: \(event)")
            }, receiveValue: { value in
                self.searchResultList = value
                if self.searchResultList.isEmpty {
                    self.setSearchEmpty(true)
                    self.searchEmptyLabel.text = I18N.Search.noSearchData
                } else {
                    self.setSearchEmpty(false)
                    self.applySnapshot()
                }
                
            })
            .store(in: &cancelBag)
    }
    
    private func setDelegate() {
        searchTextField.delegate = self
        searchTableView.delegate = self
    }
    
    private func setRegister() {
        PostListTableViewCell.register(target: self.searchTableView)
        SearchHeaderView.register(target: self.searchTableView)
    }
    
    private func setTableView() {
        self.diffableDataSource = UITableViewDiffableDataSource<Int, PostListModel>(tableView: self.searchTableView) {(tableView, indexPath, itemIdentifier) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostListTableViewCell.className, for: indexPath) as? PostListTableViewCell else { return UITableViewCell() }
            let data = self.searchResultList[indexPath.row]
            cell.selectionStyle = .none
            cell.initCell(isNew: data.isNew, title: data.title, writer: data.writer, date: data.date)
            return cell
        }
        
        if #available(iOS 15.0, *) {
            self.searchTableView.sectionHeaderTopPadding = 0
        } else {
            self.searchTableView.contentInsetAdjustmentBehavior = .never
        }
        self.searchTableView.dataSource = self.diffableDataSource
    }
    
    private func setAddTarget() {
        cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
        searchTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PostListModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(searchResultList)
        
        self.diffableDataSource?.apply(snapshot, animatingDifferences: true)
    }
    
    private func setSearchEmpty(_ empty: Bool) {
        self.searchTableView.isHidden = empty
        self.searchImageView.isHidden = !empty
        self.searchEmptyLabel.isHidden = !empty
    }
    
    private func hideSearchView(_ isHidden: Bool) {
        self.searchTextField.text = .none
        self.naviBar.hideNaviBar(!isHidden)
        
        UIView.animate(withDuration: 0.1,
                       delay: isHidden ? 0 : 0.2,
                       options: .curveEaseInOut) {
            [self.searchView, self.searchEmptyLabel, self.searchTableView].forEach { $0.alpha = isHidden ? 0 : 1 }
            self.postListViewPager.isHidden = !isHidden
            
            if isHidden {
                self.view.endEditing(true)
            } else {
                self.searchTextField.becomeFirstResponder()
            }
        }
    }
}

// MARK: - @objc

extension PostListVC {
    @objc
    private func tappedCancelButton() {
        hideSearchView(true)
    }
    
    @objc
    private func textFieldChanged() {
        if self.searchTextField.isEmpty {
            setSearchEmpty(true)
            self.searchEmptyLabel.text = I18N.Search.enterSearch
        } else {
            setSearchEmpty(false)
            textChanged.send(self.searchTextField.text)
        }
    }
}

// MARK: - UITextFieldDelegate

extension PostListVC: UITextFieldDelegate {
    
}

// MARK: - UITableViewDelegate

extension PostListVC: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = searchTableView.dequeueReusableHeaderFooterView(withIdentifier: SearchHeaderView.className) as? SearchHeaderView else { return UIView() }
        headerView.initCell(searchResultList.count)
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = factory.makePostDetailVC(noticeId: 3)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
