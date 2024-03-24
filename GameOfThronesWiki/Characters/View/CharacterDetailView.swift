//
//  CharacterDetailView.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 24.03.24.
//

import SwiftUI
import ComposableArchitecture

struct CharacterDetailView: View {
    let store: StoreOf<CharacterDetailFeature>
    
    var body: some View {
        VStack (spacing: 12) {
            characterImage
                .padding(.top, 12)
            
            VStack {
                Text(store.character.title)
                    .font(.system(size: 20, weight: .light))
                    .textCase(.uppercase)
                
                houseInfo
                
                QuoteView(store: store.scope(state: \.quote, action: \.quote))
            }
            .background(in: .rect)
            
            Spacer()
        }
        .navigationBarTitle(Text(store.character.fullName))
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
//        Image(systemName: "squareshape.dashed.squareshape")
//            .resizable()
//            .scaledToFill()
//            .frame(maxWidth: 125, maxHeight: 125)
//            .clipShape(.rect(cornerRadius: 16))
    }
    
    @ViewBuilder
    private var houseInfo: some View {
        VStack {
            Text(store.character.family)
        }
        .padding()
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
                          family: "Stark",
                          image: "jon-snow.jpg",
                          imageUrl: "https://thronesapi.com/assets/images/jon-snow.jpg"))
        ) {
            CharacterDetailFeature()
        })
    }
}