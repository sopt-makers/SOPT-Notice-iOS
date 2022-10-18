//
//  PostDetailVC.swift
//  Presentation
//
//  Created by Junho Lee on 2022/10/10.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit
import Combine

import Core

import ImageSlideShow
import SnapKit
import Then

public class PostDetailVC: UIViewController {
    
    // MARK: - Properties
    
    public var viewModel: PostDetailViewModel!
    private var cancelBag = Set<AnyCancellable>()
    
    lazy var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
  
    // MARK: - UI Components
    
    private lazy var postDetailCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        cv.showsVerticalScrollIndicator = true
        cv.backgroundColor = .white
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return cv
    }()
  
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setLayout()
        self.setDelegate()
        self.registerCells()
        self.bindViewModels()
        self.setDataSource()
        self.applySnapshot()
    }
}

// MARK: - UI & Layout

extension PostDetailVC {
    
    private func setUI() {
        self.view.backgroundColor = .white
    }
    
    private func setLayout() {
        self.view.addSubviews(postDetailCollectionView)
        
        postDetailCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Methods

extension PostDetailVC {
    
    private func setDelegate() {
        postDetailCollectionView.delegate = self
    }
    
    private func registerCells() {
        PostDetailTitleCVC.register(target: postDetailCollectionView)
        PostDetailImagesCVC.register(target: postDetailCollectionView)
        PostDetailContentCVC.register(target: postDetailCollectionView)
    }
}

// MARK: - Bind

extension PostDetailVC {
  
    private func bindViewModels() {
        let input = PostDetailViewModel.Input()
        let output = self.viewModel.transform(from: input, cancelBag: self.cancelBag)
    }

}

// MARK: - DiffableDataSource

extension PostDetailVC {
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: postDetailCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch Section.type(indexPath.section) {
            case .title:
                guard let titleCell = collectionView.dequeueReusableCell(withReuseIdentifier: PostDetailTitleCVC.className, for: indexPath) as? PostDetailTitleCVC else { return UICollectionViewCell() }
                return titleCell
                
            case .images:
                guard let imagesCell = collectionView.dequeueReusableCell(withReuseIdentifier: PostDetailImagesCVC.className, for: indexPath) as? PostDetailImagesCVC else { return UICollectionViewCell() }
                imagesCell.imageViewTapped
                    .sink { error in
                        print(error)
                    } receiveValue: { [weak self] in
                        guard let self = self else { return }
                        self.presentImageSlide()
                    }.store(in: &self.cancelBag)

                return imagesCell
                
            case .content:
                guard let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: PostDetailContentCVC.className, for: indexPath) as? PostDetailContentCVC else { return UICollectionViewCell() }
                return contentCell
            }
        })
    }
    
    // TODO: - image 수에 따라 데이터 받고 appendItems 분기처리하기
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.title, .images, .content])
        snapshot.appendItems([1],toSection: .title)
        snapshot.appendItems([2],toSection: .images)
        snapshot.appendItems([3],toSection: .content)
        dataSource.apply(snapshot, animatingDifferences: false)
        self.view.setNeedsLayout()
    }
}

// MARK: - UICollectionViewDelegate

extension PostDetailVC: UICollectionViewDelegate {

}
