//
//  SettingVC.swift
//  Presentation
//
//  Created by devxsby on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

import Combine
import SnapKit
import Then

public class SettingVC: UIViewController {
    
    // MARK: - Properties
    
    public var viewModel: SettingViewModel!
    private var cancelBag = Set<AnyCancellable>()
  
    // MARK: - UI Components
    
    private lazy var settingListTableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
  
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModels()
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
    
    private func setDelegate() {
        self.settingListTableView.delegate = self
        self.settingListTableView.dataSource = self
    }
    
    private func registerCells() {
        self.settingListTableView.register(SettingTVC.self, forCellReuseIdentifier: SettingTVC.className)
    }
}

// MARK: - Methods

extension SettingVC {
  
    private func bindViewModels() {
        let input = SettingViewModel.Input()
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
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
        return SettingTVC.SettingCellType.allCases.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingTVC.className, for: indexPath)
                as? SettingTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        let cellType = SettingTVC.SettingCellType.allCases[indexPath.item]
        
        switch cellType {
        case .pushAlarm:
            cell.titleLabel.text = "푸시 알림 설정"
            cell.detailVCButton.isEnabled = true
        case .termsOfService:
            cell.titleLabel.text = "서비스 이용약관"
            cell.detailVCButton.tintColor = .white
            cell.detailVCButton.isEnabled = false
        case .privacyPolicy:
            cell.titleLabel.text = "개인정보 처리방침"
            cell.detailVCButton.tintColor = .white
            cell.detailVCButton.isEnabled = false
        }
        return cell
    }
}
