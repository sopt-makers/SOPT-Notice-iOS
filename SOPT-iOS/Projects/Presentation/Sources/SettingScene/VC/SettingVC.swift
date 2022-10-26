//
//  SettingVC.swift
//  Presentation
//
//  Created by devxsby on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

import SnapKit
import Then

import Core
import DSKit

public class SettingVC: UIViewController {
    
    // MARK: - Properties
    public var factory: ModuleFactoryInterface!
    public var viewModel: SettingViewModel!
  
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .leftTitleWithLeftButton)
        .setTitle(I18N.Setting.setting)
    
    private lazy var settingListTableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let dividerView = UIView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray200.color
    }
  
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setLayout()
        self.setDelegate()
        self.registerCells()
    }
}

// MARK: - UI & Layout

extension SettingVC {
    
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    private func setLayout() {
        self.view.addSubviews(naviBar, dividerView, settingListTableView)
        
        naviBar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        dividerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(naviBar.snp.bottom).offset(8)
            make.height.equalTo(1)
        }
        
        settingListTableView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Methods

extension SettingVC {
    
    private func setDelegate() {
        self.settingListTableView.delegate = self
        self.settingListTableView.dataSource = self
    }
    
    private func registerCells() {
        self.settingListTableView.register(SettingTVC.self, forCellReuseIdentifier: SettingTVC.className)
    }
}

// MARK: - UITableViewDelegate

extension SettingVC: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDataSource

extension SettingVC: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getSettingCellCount()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingTVC.className, for: indexPath)
                as? SettingTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        let cellType = SettingViewModel.SettingCellType.allCases[indexPath.item]
        cell.titleLabel.text = viewModel.getSettingCellTitle(cellType: cellType)
        cell.detailVCButton.isHidden = viewModel.setButtonState(cellType: cellType)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            let pushAlarmSettingVC = factory.makePushAlarmSettingVC()
            navigationController?.pushViewController(pushAlarmSettingVC, animated: true)
        default:
            break
        }
    }
}
