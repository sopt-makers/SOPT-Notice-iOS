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

public class SettingVC: UIViewController {
    
    // MARK: - Properties
    public var factory: ModuleFactoryInterface!
    public var viewModel: SettingViewModel!
  
    // MARK: - UI Components
    
    private lazy var settingListTableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        return tableView
    }()
  
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
        self.view.addSubview(settingListTableView)
        settingListTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
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
