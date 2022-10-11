//
//  PostDetailCompositionalLayout.swift
//  Presentation
//
//  Created by Junho Lee on 2022/10/10.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

import Core

extension PostDetailVC {
    static let standardWidth = UIScreen.main.bounds.width - 32.adjusted
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch Section.type(sectionIndex) {
            case .title: return self.createTitleSection()
            case .images: return self.createImagesSection()
            case .content: return self.createContentSection()
            }
        }
    }
    
    private func createTitleSection() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .absolute(PostDetailVC.standardWidth), heightDimension: .estimated(97))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 16.adjusted, bottom: 16.adjustedH, trailing: 16.adjusted)
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
    private func createImagesSection() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .absolute(PostDetailVC.standardWidth), heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 16.adjusted, bottom: 0, trailing: 16.adjusted)
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
    private func createContentSection() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .absolute(PostDetailVC.standardWidth), heightDimension: .estimated(97))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 24.adjustedH, leading: 16.adjusted, bottom: 0, trailing: 16.adjusted)
        section.orthogonalScrollingBehavior = .none
        return section
    }
}

