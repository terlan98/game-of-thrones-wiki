//
//  CharacterDetailView.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 24.03.24.
//

import SwiftUI
import ComposableArchitecture

struct CharacterDetailView: View {
    @Bindable var store: StoreOf<CharacterDetailFeature>
    
    var body: some View {
        VStack (spacing: 12) {
            characterImage
                .padding(.top, 12)
            
            VStack {
                Text(store.character.title)
                    .font(.system(size: 18, weight: .light))
                    .textCase(.uppercase)
                
                toggleFavoritesButton
                
                QuoteView(store: store.scope(state: \.quote, action: \.quote))
                
                HouseView(house: store.character.family)
            }
            .background(in: .rect)
            
            Spacer()
        }
        .navigationBarTitle(Text(store.character.fullName))
        .onAppear {
            store.send(.fetchFavoriteStatus)
        }
    }
    
    @ViewBuilder
    private var characterImage: some View {
        AsyncImage(url: URL(string: store.character.imageUrl)) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(maxWidth: 140, maxHeight: 140)
                .clipShape(.rect(cornerRadius: 12))
        } placeholder: {
            ProgressView()
        }
    }
    
    @ViewBuilder
    private var toggleFavoritesButton: some View {
        Button(action: {
            store.send(.favoriteButtonTapped)
        }, label: {
            HStack {
                Image(systemName: store.isFavorite ? "star.circle" : "star.circle.fill")
                    .font(.system(size: 20, weight: .regular))
                Text(store.isFavorite ? "Remove from Favorites" : "Add to Favorites")
                    .textCase(.uppercase)
            }
            .font(.system(size: 14, weight: .semibold))
            .padding(12)
            .background(in: .rect(cornerRadius: 10))
            .backgroundStyle(.tertiary.opacity(0.25))
        })
    }
}

#Preview {
    NavigationStack {
        CharacterDetailView(store: Store(
            initialState: CharacterDetailFeature.State(character:
                    .init(id: 0,
                          firstName: "Jon",
                          lastName: "Snow",
                          fullName: "Jon Snow",
                          title: "King of the North",
                          family: .stark,
                          image: "jon-snow.jpg",
                          imageUrl: "https://thronesapi.com/assets/images/jon-snow.jpg"))
        ) {
            CharacterDetailFeature()
        })
    }
}
