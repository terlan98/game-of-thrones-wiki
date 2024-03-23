//
//  CharactersView.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 23.03.24.
//

import SwiftUI
import ComposableArchitecture

struct CharactersView: View {
    let store: StoreOf<CharactersFeature>
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
              ForEach(store.characters) { character in
                Text(character.fullName)
              }
            }
        }
        .onAppear {
            store.send(.fetchTriggered)
        }
    }
}

#Preview {
    CharactersView(store: Store(initialState: CharactersFeature.State()) {
        CharactersFeature()
    })
}
