//
//  SolarPost.swift
//  Runner
//
//  Created by LittleSheep on 2024/12/14.
//


import Foundation

struct SolarPost : Codable {
    let id: Int
    let body: SolarPostBody
    let publisher: SolarPublisher
    let publisherId: Int
    let createdAt: Date
    let updatedAt: Date
    let editedAt: Date?
    let publishedAt: Date?
}

struct SolarPostBody : Codable {
    let content: String?
    let title: String?
    let description: String?
    let attachments: [String]?
}

struct SolarPublisher : Codable {
    let id: Int
    let name: String
    let nick: String
    let description: String?
    let avatar: String?
    let banner: String?
    let createdAt: Date
    let updatedAt: Date
}
