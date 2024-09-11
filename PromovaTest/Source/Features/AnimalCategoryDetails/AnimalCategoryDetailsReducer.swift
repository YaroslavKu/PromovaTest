//
//  AnimalCategoryDetailsReducer.swift
//  PromovaTest
//
//  Created by Yaroslav Kukhar on 09.09.2024.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct AnimalCategoryDetailReducer {

    @ObservableState
    struct State: Equatable {
        var animalCategory: AnimalCategory
        var currentFactIndex: Int = 0 // Track the index of the current fact
    }
    
    enum Action: Equatable {
        case nextFact
        case previousFact
        case swipeNext
        case swipePrevious
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .nextFact, .swipeNext:
                if let facts = state.animalCategory.content, state.currentFactIndex < facts.count - 1 {
                    state.currentFactIndex += 1
                }
                return .none
                
            case .previousFact, .swipePrevious:
                if state.currentFactIndex > 0 {
                    state.currentFactIndex -= 1
                }
                return .none
            }
        }
    }
}
