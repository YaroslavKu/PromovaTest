//
//  AnimalCategoryListReducer.swift
//  PromovaTest
//
//  Created by Yaroslav Kukhar on 08.09.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AnimalCategoryListReducer {
    
    @ObservableState
    struct State {
        var isLoading = false
        var animalCategories: [AnimalCategory] = []
    }
    
    enum Action {
        case load
        case loaded(Result<[AnimalCategory], Error>)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .load:
            state.isLoading = true
            return .run { send in
                do {
                    let res = try await AnimalApi().fetchAnimalCategories()
                    await send(.loaded(.success(res)))
                } catch {
                    await send(.loaded(.failure(error)))
                }
            }
        case let .loaded(.success(categories)):
            state.animalCategories = categories.sorted { $0.order < $1.order }
            state.isLoading = false
            return .none
        case let .loaded(.failure(error)):
            print(error.localizedDescription)
            state.isLoading = false
            return .none
        }
    }
}
