//
//  PushAlarmSettingVC.swift
//  Presentation
//
//  Created by devxsby on 2022/10/20.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit
import Core
import DSKit

import Combine
import SnapKit
import Then

import Core

public class PushAlarmSettingVC: UIViewController {
    
    // MARK: - Properties
    
    public var viewModel: PushAlarmSettingViewModel!
    private var cancelBag = CancelBag()
    private var pushToggleList = Array(repeating: false, count: 7)
  
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .leftTitleWithLeftButton)
        .setTitle(I18N.Setting.pushSetting)
        .setRightButtonTitle(I18N.Setting.check)
        .rightButtonAction {
            print("확인 누름")
        }
    
    private let dividerView = UIView().then {
        $0.backgroundColor = DSKitAsset.Colors.gray200.color
    }
    
    private lazy var partListTableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let captionLabel = UILabel().then {
        $0.text = """
                  알림이 오지 않는다면 [기기 내 설정 > 알림]에서
                  알림 설정을 확인해주세요.
                  """
        $0.setTypoStyle(.caption)
        $0.textColor = DSKitAsset.Colors.gray600.color
        $0.numberOfLines = 2
        $0.setLineSpacing(lineSpacing: 4)
        $0.textAlignment = .left
    }
  
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

extension PushAlarmSettingVC {
    
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    private func setLayout() {
        self.view.addSubviews(naviBar, dividerView, partListTableView, captionLabel)
        
        naviBar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        dividerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(naviBar.snp.bottom).offset(8)
            make.height.equalTo(1)
        }
        
        partListTableView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(56 * 7 + 1)
        }
        
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(partListTableView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }
    }
    
    private func setDelegate() {
        self.partListTableView.delegate = self
        self.partListTableView.dataSource = self
    }
    
    private func registerCells() {
        self.partListTableView.register(PushAlarmPartTVC.self, forCellReuseIdentifier: PushAlarmPartTVC.className)
    }
}

// MARK: - Methods

extension PushAlarmSettingVC {
  
    private func bindViewModels() {
        let input = PushAlarmSettingViewModel.Input(viewDidLoad: Driver.just(()))
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
        
        output.$pushSettingList
            .compactMap { $0 }
            .sink { model in
                self.pushToggleList = model.pushSettingList
                self.partListTableView.reloadData()
            }.store(in: self.cancelBag)
    }
    
    private func setToggleList(_ model: PushAlarmSettingViewModel) {
        
    }
}

// MARK: - UITableViewDelegate

extension PushAlarmSettingVC: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDataSource

extension PushAlarmSettingVC: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getPartListCount()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PushAlarmPartTVC.className, for: indexPath)
                as? PushAlarmPartTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        let cellType = PushAlarmSettingViewModel.PartList.allCases[indexPath.item]
        let isOn = pushToggleList[indexPath.item]
        cell.initCell(title: cellType.title, isOn: isOn)
        return cell
    }
}
