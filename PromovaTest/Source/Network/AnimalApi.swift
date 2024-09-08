//
//  AnimalApi.swift
//  PromovaTest
//
//  Created by Yaroslav Kukhar on 09.09.2024.
//

import Foundation

struct AnimalApi {
    func fetchAnimalCategories() async throws -> [AnimalCategory] {
        let url = URL(string: "https://raw.githubusercontent.com/AppSci/promova-test-task-iOS/main/animals.json")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([AnimalCategory].self, from: data)
    }
}
