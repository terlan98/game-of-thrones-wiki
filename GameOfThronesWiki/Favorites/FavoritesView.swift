//
//  FavoritesView.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 25.03.24.
//

import SwiftUI
import ComposableArchitecture

struct FavoritesView: View {
    @Bindable var store: StoreOf<FavoritesFeature>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ScrollView {
                favoritesList
            }
            .navigationTitle("Favorites")
            .onAppear {
                store.send(.fetchFavorites)
            }
        } destination: { store in
            CharacterDetailView(store: store)
        }
    }
    
    @ViewBuilder
    private var favoritesList: some View {
        VStack(alignment: .leading, spacing: 16) {
            if store.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            } else if store.favorites.isEmpty {
                FavoritesEmptyView()
            } else {
                ForEach(store.favorites) { character in
                    NavigationLink(state: CharacterDetailFeature.State(character: character, quote: QuoteFeature.State(character: character))) {
                        CharacterCellView(character: character)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(Color.cyan)
                .opacity(0.1)
        }
        .padding()
    }
}

#Preview {
    FavoritesView(store: Store(initialState: FavoritesFeature.State()) {
        FavoritesFeature()
    })
}
