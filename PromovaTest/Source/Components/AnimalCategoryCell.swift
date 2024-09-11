//
//  AnimalCategoryView.swift
//  PromovaTest
//
//  Created by Yaroslav Kukhar on 09.09.2024.
//

import Foundation
import SwiftUI

struct AnimalCategoryCell: View {
    let model: AnimalCategory
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: model.image)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 90)
            } placeholder: {
                Color.gray.frame(width: 120, height: 90)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(model.title)
                    .font(.headline)
                Text(model.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
                if model.status == "paid" {
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.blue)
                        Text("Premium")
                            .foregroundColor(.blue)
                            .font(.subheadline)
                    }
                }
            }.frame(height: 100)
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        )
        .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 2)
        .overlay(
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill((model.content?.isEmpty ?? true) ? Color.black.opacity(0.7) : Color.clear)
            }
        )
    }
}

