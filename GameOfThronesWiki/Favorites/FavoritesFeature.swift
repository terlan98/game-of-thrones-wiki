//
//  FavoritesFeature.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 25.03.24.
//

import ComposableArchitecture
import OSLog

@Reducer
struct FavoritesFeature {
    private var logger = Logger(subsystem: "GameOfThronesWiki", category: "FavoritesFeature")
    @Dependency(\.favoritesService) var favoritesService
    
    @ObservableState
    struct State: Equatable {
        var favorites: IdentifiedArrayOf<Character> = []
        var isLoading = false
        
        var path = StackState<CharacterDetailFeature.State>()
    }
    
    enum Action {
        case fetchFavorites
        case favoritesFetched(IdentifiedArrayOf<Character>)
        case toggleFavorite(Character)
        
        case path(StackAction<CharacterDetailFeature.State, CharacterDetailFeature.Action>)
        
        case delegate(Delegate)
        enum Delegate: Equatable {
            case addCharacterToFavorites(Character)
            case removeCharacterFromFavorites(Character)
            case favoritesFetched(IdentifiedArrayOf<Character>)
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchFavorites:
                state.isLoading = true
                
                let characters = favoritesService.fetch()
                logger.info("Fetched \(characters.count) favorites")
                
                return .send(.favoritesFetched(characters))
                    .concatenate(with: .send(.delegate(.favoritesFetched(characters))))
                
            case let .favoritesFetched(characters):
                state.isLoading = false
                state.favorites = characters
                
                return .none
                
            case let .toggleFavorite(character):
                if state.favorites.contains(character) {
                    let updatedFavorites = favoritesService.remove(character)
                    logger.info("Removed \(character.fullName) from favorites")
                    
                    return .send(.favoritesFetched(updatedFavorites))
                        .concatenate(with: .send(.delegate(.removeCharacterFromFavorites(character))))
                    
                } else {
                    let updatedFavorites = favoritesService.add(character)
                    logger.info("Added \(character.fullName) to favorites")
                    
                    return .send(.favoritesFetched(updatedFavorites))
                        .concatenate(with: .send(.delegate(.addCharacterToFavorites(character))))
                }
                
            case .path, .delegate:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            CharacterDetailFeature()
        }
    }
}
