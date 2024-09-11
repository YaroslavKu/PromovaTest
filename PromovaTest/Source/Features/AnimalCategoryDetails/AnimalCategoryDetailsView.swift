//
//  AnimalCategoryDetailsView.swift
//  PromovaTest
//
//  Created by Yaroslav Kukhar on 09.09.2024.
//

import SwiftUI
import ComposableArchitecture

struct AnimalCategoryDetailView: View {
    let store: StoreOf<AnimalCategoryDetailReducer>
    
    var body: some View {
        let currentFact = store.animalCategory.content?[store.currentFactIndex]
        
        VStack {
            if let fact = currentFact {
                // ShareLink for sharing the current fact
                ShareLink(
                    item: fact.fact, // Sharing the fact text
                    preview: SharePreview(fact.fact)
                ) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share")
                    }
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding()
                
                AsyncImage(url: URL(string: fact.image)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(height: 300)
                } placeholder: {
                    ProgressView()
                }
                
                Text(fact.fact)
                    .font(.title)
                    .padding()
            } else {
                Text("No facts available")
                    .font(.title)
                    .padding()
            }
            
            HStack {
                Button(action: {
                    store.send(.previousFact)
                }) {
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.largeTitle)
                }
                .disabled(store.currentFactIndex == 0) // Disable if at the first fact
                
                Spacer()
                
                Button(action: {
                    store.send(.nextFact)
                }) {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.largeTitle)
                }
                .disabled(store.animalCategory.content?.count == nil || store.currentFactIndex == store.animalCategory.content!.count - 1)
            }
            .padding(.horizontal)
        }
        .navigationTitle(store.animalCategory.title)
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < -50 {
                        store.send(.swipeNext)
                    } else if value.translation.width > 50 {
                        store.send(.swipePrevious)
                    }
                }
        )
    }
}





//#Preview {
//    AnimalCategoryDetailsView(store: <#StoreOf<AnimalCategoryDetailsReducer>#>)
//}
