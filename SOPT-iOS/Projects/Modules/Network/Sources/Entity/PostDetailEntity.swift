//
//  PostDetailEntity.swift
//  Network
//
//  Created by Junho Lee on 2022/10/17.
//  Copyright © 2022 SOPT-iOS. All rights reserved.
//

import Foundation

public struct MainMapEntity: Codable {
    public let id, name: String
    public let longitude, latitude: Double
    public let isDietRestaurant: Bool

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, longitude, latitude, isDietRestaurant
    }
}
