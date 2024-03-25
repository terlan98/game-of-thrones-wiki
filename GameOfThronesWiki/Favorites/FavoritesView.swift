//
//  FavoritesView.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 25.03.24.
//

import SwiftUI
import ComposableArchitecture

struct FavoritesView: View {
    var store: StoreOf<CharactersFeature>
    
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    FavoritesView(store: Store(initialState: CharactersFeature.State()) {
        CharactersFeature()
    })
}
