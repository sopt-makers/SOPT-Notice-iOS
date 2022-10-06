//
//  ViewModelType.swift
//  Core
//
//  Created by 양수빈 on 2022/10/06.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

protocol ViewModelType{
  associatedtype Input
  associatedtype Output
  
  func transform(from input: Input) -> Output
}

