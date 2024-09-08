//
//  AnimalCategory.swift
//  PromovaTest
//
//  Created by Yaroslav Kukhar on 09.09.2024.
//

import Foundation

struct AnimalCategory: Decodable, Equatable {
    let title: String
    let description: String
    let image: String
    let order: Int
    let status: String
    let content: [Content]?
}

struct Content: Decodable, Equatable {
    let fact: String
    let image: String
}
