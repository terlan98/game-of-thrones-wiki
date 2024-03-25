//
//  ContentView.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 22.03.24.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: StoreOf<TabFeature>
    
    var body: some View {
        TabView {
            CharactersView(store: store.scope(state: \.tab1, action: \.tab1))
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Characters")
                }
            
            FavoritesView(store: store.scope(state: \.tab2, action: \.tab2))
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
        }
    }
}

#Preview {
    ContentView(
        store: Store(initialState: TabFeature.State()) {
            TabFeature()
        }
    )
}
