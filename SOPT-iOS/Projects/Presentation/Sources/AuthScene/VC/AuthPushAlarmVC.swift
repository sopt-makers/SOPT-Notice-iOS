//
//  AuthPushAlarmVC.swift
//  Presentation
//
//  Created by devxsby on 2022/10/23.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit
import DSKit

import Combine
import SnapKit
import Then

public class AuthPushAlarmVC: UIViewController {
    
    // MARK: - Properties
    
    public var factory: ModuleFactoryInterface!
    public var viewModel: AuthPushAlarmViewModel!
    private var cancelBag = Set<AnyCancellable>()
  
    // MARK: - UI Components
    
    private lazy var naviBar = CustomNavigationBar(self, type: .onlyRightButton)
           .setRightButtonTitle("확인")
    
    private let titleLabel = UILabel().then {
        $0.setTypoStyle(.h2)
        let attributedString = NSMutableAttributedString(string: "푸시알림 ", attributes: [NSAttributedString.Key.foregroundColor: DSKitAsset.Colors.blue500.color])
        attributedString.append(NSAttributedString(string: "받을 파트를\n선택해 주세요.",
                                                   attributes: [.foregroundColor: DSKitAsset.Colors.gray900.color]))
        $0.attributedText = attributedString
        $0.numberOfLines = 2
    }
    
    private let subtitleLabel = UILabel().then {
        $0.text = """
                  새로운 공지가 올라오면
                  선택한 파트의 소식을 받아볼 수 있어요.
                  """
        $0.textColor = DSKitAsset.Colors.gray500.color
        $0.textAlignment = .left
        $0.setTypoStyle(.body1)
        $0.setLineSpacing(lineSpacing: 4)
        $0.numberOfLines = 2
    }
    
    private lazy var putOffButton = UIButton(type: .system).then {
        $0.setTitle("다음에 하기 >", for: .normal)
        $0.setTitleColor(DSKitAsset.Colors.gray400.color, for: .normal)
        $0.titleLabel!.setTypoStyle(.caption)
        $0.contentHorizontalAlignment = .left
        $0.addTarget(self, action: #selector(putOffButtonDidTap), for: .touchUpInside)
    }
    
    private lazy var partListTableView: UITableView = {
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
        self.bindViewModels()
        self.setUI()
        self.setLayout()
        self.setNaviAction()
        self.setDelegate()
        self.registerCells()
    }
}

// MARK: - UI & Layout

extension AuthPushAlarmVC {
    
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    private func setLayout() {
        self.view.addSubviews(naviBar, titleLabel, subtitleLabel, putOffButton, partListTableView)
        
        naviBar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        putOffButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(66)
            make.height.equalTo(16)
        }
    
        partListTableView.snp.makeConstraints { make in
            make.top.equalTo(putOffButton.snp.bottom).offset(26)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(400)
        }
    }
}

// MARK: - Methods

extension AuthPushAlarmVC {
  
    private func bindViewModels() {
        let input = AuthPushAlarmViewModel.Input()
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
    }
    
    private func setDelegate() {
        self.partListTableView.delegate = self
        self.partListTableView.dataSource = self
    }
    
    private func registerCells() {
        self.partListTableView.register(AuthPushAlarmTVC.self, forCellReuseIdentifier: AuthPushAlarmTVC.className)
    }
    
    private func setNaviAction() {
        naviBar.rightButtonAction {
            print("navi button did tap")
        }
    }
    
    @objc private func putOffButtonDidTap() {
        print("put Off Button Did Tap")
    }
}

// MARK: - UITableViewDelegate

extension AuthPushAlarmVC: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDataSource

extension AuthPushAlarmVC: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getPartListCount()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AuthPushAlarmTVC.className, for: indexPath)
                as? AuthPushAlarmTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        let cellType = AuthPushAlarmViewModel.PartList.allCases[indexPath.item]
        cell.initCell(indexPath.item, cellType: cellType)
        
        return cell
    }
}
