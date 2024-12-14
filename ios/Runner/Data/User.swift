//
//  SolarData.swift
//  Runner
//
//  Created by LittleSheep on 2024/12/14.
//

import Foundation

struct SolarUser: Codable {
    let id: Int
    let name: String
    let nick: String
}

struct SolarCheckInRecord: Codable {
    let id: Int
    let resultTier: Int
    let createdAt: Date
}
