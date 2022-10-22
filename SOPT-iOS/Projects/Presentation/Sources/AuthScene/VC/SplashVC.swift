//
//  SplashVC.swift
//  Presentation
//
//  Created by devxsby on 2022/10/22.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit
import DSKit

import SnapKit
import Then

public class SplashVC: UIViewController {
    
    // MARK: - Properties
    public var factory: ModuleFactoryInterface!
    
    // MARK: - UI Components
    
    private let logoImage = UIImageView().then {
        $0.image = DSKitAsset.Assets.logo.image.withRenderingMode(.alwaysOriginal)
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    private let titleLabel = UILabel().then {
        $0.setTypoStyle(.body2)
        $0.text = "Shout Our Passion Together"
        $0.textColor = DSKitAsset.Colors.gray500.color
        $0.textAlignment = .center
    }
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setLayout()
        self.setDelay()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        self.setNavigationBar()
    }
}

// MARK: - UI & Layout

extension SplashVC {
    
    private func setUI() {
        self.view.backgroundColor = DSKitAsset.Colors.gray900.color
    }
    
    private func setLayout() {
        self.view.addSubviews(logoImage, titleLabel)
        
        logoImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(140)
            make.height.equalTo(49).multipliedBy(1.87)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - Methods

extension SplashVC {
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let settingVC = self.factory.makeSettingVC()
            self.navigationController?.pushViewController(settingVC, animated: true)
        }
    }
}
