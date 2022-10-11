//
//  PostDetailSection.swift
//  Presentation
//
//  Created by Junho Lee on 2022/10/10.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

enum Section: CaseIterable {
    case title
    case images
    case content
    
    static func type(_ index: Int) -> Section {
        return self.allCases[index]
    }
}

