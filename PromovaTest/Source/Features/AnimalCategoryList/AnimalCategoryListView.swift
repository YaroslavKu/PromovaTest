//
//  AnimalCategoryListView.swift
//  PromovaTest
//
//  Created by Yaroslav Kukhar on 08.09.2024.
//

import SwiftUI
import ComposableArchitecture

struct AnimalCategoryListView: View {
    @Perception.Bindable var store: StoreOf<AnimalCategoryListReducer>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ZStack {
                Color(hex: "#CCCCFF").ignoresSafeArea() // background
                
                if store.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        ForEach(store.animalCategories) { category in
                            if category.status == "free" {
                                NavigationLink(state: AnimalCategoryDetailReducer.State(animalCategory: category)) {
                                    AnimalCategoryCell(model: category)
                                        .padding(.horizontal)
                                }
                            } else {
                                AnimalCategoryCell(model: category)
                                    .padding(.horizontal)
                                    .onTapGesture {
                                        store.send(.unavailableTapped)
                                    }
                            }
                        }
                    }
                }
            }
            
        } destination: { store in
            AnimalCategoryDetailView(store: store)
        }
        .onAppear {
            store.send(.load)
        }
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

#Preview {
    AnimalCategoryListView(store: Store(initialState: AnimalCategoryListReducer.State(), reducer: {
        AnimalCategoryListReducer()
    }))
}
