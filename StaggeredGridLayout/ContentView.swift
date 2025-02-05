//
//  ContentView.swift
//  StaggeredGridLayout
//
//  Created by Lulwah almisfer on 05/02/2025.
//

import SwiftUI

struct GridItemModel: Identifiable {
    let id: Int
    let height: CGFloat
    let color = Color(
        red: Double.random(in: 0...1),
        green: Double.random(in: 0...1),
        blue: Double.random(in: 0...1)
    )
}

struct ContentView: View {
    
    let items = (1...20).map { GridItemModel(id: $0, height: CGFloat.random(in: 100...300)) }
    
    var body: some View {
        ScrollView {
            StaggeredGridLayout(columns: 3, spacing: 10) {
                ForEach(items) { item in
                    Rectangle()
                        .fill(item.color)
                        .frame(height: item.height)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
