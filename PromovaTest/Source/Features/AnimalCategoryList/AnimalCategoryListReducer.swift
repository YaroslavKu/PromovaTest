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
    struct State: Equatable {
        var isLoading = false
        var animalCategories: [AnimalCategory] = []
        var path = StackState<AnimalCategoryDetailReducer.State>()
        
        
        @Presents var alert: AlertState<Action.Alert>?
    }
    
    enum Action {
        case load
        case loaded(Result<[AnimalCategory], Error>)
        case path(StackAction<AnimalCategoryDetailReducer.State, AnimalCategoryDetailReducer.Action>)
        case alert(PresentationAction<Alert>)
        case unavailableTapped
        enum Alert: Equatable {
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
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
            case .path:
                return .none
            case .unavailableTapped:
                state.alert = AlertState {
                  TextState("Content is unavailable")
                } actions: {
                    ButtonState(role: .cancel) {
                        TextState("Ok")
                    }
                }
                return .none
            case .alert:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            AnimalCategoryDetailReducer()
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
