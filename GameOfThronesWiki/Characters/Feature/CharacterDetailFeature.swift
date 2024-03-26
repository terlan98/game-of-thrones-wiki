//
//  CharacterDetailFeature.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 24.03.24.
//

import ComposableArchitecture

@Reducer
struct CharacterDetailFeature {
    @Dependency(\.favoritesService) var favoritesService
    
    @ObservableState
    struct State: Equatable {
        let character: Character
        var quote = QuoteFeature.State()
        var favorites = FavoritesFeature.State()
        var isFavorite = false
    }
    
    enum Action {
        case quote(QuoteFeature.Action)
        case favorites(FavoritesFeature.Action)
        case fetchFavoriteStatus
        case favoriteButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.quote, action: \.quote) {
            QuoteFeature()
        }
        
        Scope(state: \.favorites, action: \.favorites) {
            FavoritesFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .fetchFavoriteStatus:
                return .send(.favorites(.fetchFavorites))
                
            case .favorites(.delegate(.favoritesFetched)):
                state.isFavorite = state.favorites.favorites.contains(state.character)
                return .none
            
            case .favoriteButtonTapped:
                return .send(.favorites(.toggleFavorite(state.character)))
                
            case .favorites(.delegate(.addCharacterToFavorites)):
                state.isFavorite = true
                return .none
            
            case .favorites(.delegate(.removeCharacterFromFavorites)):
                state.isFavorite = false
                return .none
            
            case .favorites, .quote:
                return .none
            }
        }
    }
}


