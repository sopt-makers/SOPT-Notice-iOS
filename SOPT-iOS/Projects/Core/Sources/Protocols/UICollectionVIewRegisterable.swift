//
//  UICollectionVIewRegisterable.swift
//  Core
//
//  Created by 양수빈 on 2022/10/06.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import UIKit

protocol UICollectionViewRegisterable {
    static var isFromNib: Bool { get }
    static func register(target: UICollectionView)
}

protocol UIICollectionReusableViewRegisterable {
    static var isFromNib: Bool { get }
    static func register(target: UICollectionView, isHeader: Bool)
}

extension UICollectionViewRegisterable where Self: UICollectionViewCell {
    static func register(target: UICollectionView) {
        if self.isFromNib {
            target.register(UINib(nibName: Self.className, bundle: nil), forCellWithReuseIdentifier: Self.className)
        } else {
            target.register(Self.self, forCellWithReuseIdentifier: Self.className)
        }
    }
}

extension UIICollectionReusableViewRegisterable where Self: UICollectionReusableView {
    static func register(target: UICollectionView, isHeader: Bool) {
        if self.isFromNib {
            if isHeader {
                target.register(UINib(nibName: Self.className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Self.className)
            } else {
                target.register(UINib(nibName: Self.className, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Self.className)
            }
        } else {
            if isHeader {
                target.register(Self.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Self.className)
            } else {
                target.register(Self.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Self.className)
            }
        }
    }
}
