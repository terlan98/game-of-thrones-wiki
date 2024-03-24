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
                QuoteView(store: store.scope(state: \.quote, action: \.quote))
                
                charactersList
            }
            .navigationTitle("Characters")
        }
        .onAppear {
            store.send(.fetchTriggered)
        }
    }
    
    @ViewBuilder
    private var charactersList: some View {
        VStack(alignment: .leading, spacing: 16) {
            if store.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            } else if store.fetchFailed {
                VStack(spacing: 20) {
                    CharactersErrorView()
                    retryButton
                }
            } else {
                ForEach(store.characters) { character in
                    CharacterCellView(character: character)
                }
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color.cyan)
                .opacity(store.fetchFailed ? 0 : 0.2)
        }
        .padding()
    }
    
    @ViewBuilder
    private var retryButton: some View {
        Button {
            store.send(.fetchTriggered)
        } label: {
            Text("Try Again")
                .textCase(.uppercase)
                .font(.system(size: 14, weight: .semibold))
                .padding()
                .background(in: .rect(cornerRadius: 10))
                .backgroundStyle(.fill.opacity(0.5))
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
