//
//  PushAlarmSettingVC.swift
//  Presentation
//
//  Created by devxsby on 2022/10/20.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit
import DSKit

import Combine
import SnapKit
import Then

public class PushAlarmSettingVC: UIViewController {
    
    // MARK: - Properties
    
    public var viewModel: PushAlarmSettingViewModel!
    private var cancelBag = Set<AnyCancellable>()
  
    // MARK: - UI Components
    
    private lazy var partListTableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let captionabel = UILabel().then {
        $0.text = """
                  알림이 오지 않는다면 [기기 내 설정 > 알림]에서
                  알림 설정을 확인해주세요.
                  """
        $0.setTypoStyle(.caption)
        $0.textColor = DSKitAsset.Colors.gray600.color
        $0.numberOfLines = 2
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
        self.view.addSubviews(partListTableView, captionabel)
        
        partListTableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(56 * 7 + 1)
        }
        
        captionabel.snp.makeConstraints { make in
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
        let input = PushAlarmSettingViewModel.Input()
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
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
        cell.titleLabel.text = cellType.title
        return cell
    }
}
