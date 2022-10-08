//
//  SampleEntity.swift
//  Data
//
//  Created by 양수빈 on 2022/10/07.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

import Domain

public struct SampleEntity: Codable {
    let titleEntity: String
    
    public func toDomain() -> SampleModel {
        return SampleModel.init(title: titleEntity)
    }
}
