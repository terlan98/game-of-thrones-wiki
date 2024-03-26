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
                favoritesList // FIXME: does not update when navigating back from a CharacterDetailView
            }
            .navigationTitle("Favorites")
        } destination: { store in
            CharacterDetailView(store: store)
        }
        .onAppear {
            store.send(.fetchFavorites)
        }
    }
    
    @ViewBuilder
    private var favoritesList: some View {
        VStack(alignment: .leading, spacing: 16) {
            if store.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            } else if store.favorites.isEmpty {
//                    FavoritesErrorView() // TODO: implement
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
