//
//  PromovaTestApp.swift
//  PromovaTest
//
//  Created by Yaroslav Kukhar on 08.09.2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct PromovaTestApp: App {
    var body: some Scene {
        WindowGroup {
            AnimalCategoryListView(store: Store(initialState: AnimalCategoryListReducer.State(), reducer: {
                AnimalCategoryListReducer()
            }))
        }
    }
}
