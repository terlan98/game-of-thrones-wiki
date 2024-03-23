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
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(store.characters) { character in
                        CharacterCellView(character: character)
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(Color.cyan.opacity(0.2))
                }
                .padding()
            }
            .navigationTitle("Characters")
        }
        .onAppear {
            store.send(.fetchTriggered)
        }
    }
}

struct CharacterCellView: View {
    var character: Character
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(character.fullName)
                    .font(.system(size: 22, weight: .semibold))
                
                Text(character.title)
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.background)
        }
        .padding(.horizontal, 2)
    }
}

#Preview {
    CharactersView(store: Store(initialState: CharactersFeature.State()) {
        CharactersFeature()
    })
}
