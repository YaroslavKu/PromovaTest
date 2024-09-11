//
//  AnimalCategory.swift
//  PromovaTest
//
//  Created by Yaroslav Kukhar on 09.09.2024.
//

import Foundation

struct AnimalCategory: Decodable, Equatable, Identifiable {
    var id: UUID = UUID()
    let title: String
    let description: String
    let image: String
    let order: Int
    let status: String
    let content: [Content]?
    
    // Custom CodingKeys to exclude `id` from decoding
    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case image
        case order
        case status
        case content
    }
}

struct Content: Decodable, Equatable, Identifiable {
    var id: UUID = UUID()
    let fact: String
    let image: String
    
    // Custom CodingKeys to exclude `id` from decoding
    private enum CodingKeys: String, CodingKey {
        case fact
        case image
    }
}
