//
//  ContentView.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 22.03.24.
//

import SwiftUI
import ComposableArchitecture

// https://gameofthronesquotes.xyz

struct ContentView: View {
    static let store = Store(initialState: CharactersFeature.State()) {
        CharactersFeature()
        ._printChanges()
    } // TODO: move to GameOfThronesWikiApp.swift

    var body: some View {
        TabView {
            CharactersView(store: Self.store)
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Characters")
                }
            
            CharactersView(store: Self.store)
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
        }
    }
}

#Preview {
    ContentView()
}
