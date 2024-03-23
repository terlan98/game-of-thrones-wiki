//
//  CharactersFeature.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 23.03.24.
//

import ComposableArchitecture
import OSLog

// TODO: write tests
@Reducer
struct CharactersFeature {
    private var logger = Logger(subsystem: "GameOfThronesWiki", category: "CharactersFeature")
    @Dependency(\.charactersService) var charactersService
    
    @ObservableState
    struct State {
        var characters: IdentifiedArrayOf<Character> = []
        var isLoading = false
        var fetchFailed = false
    }
    
    enum Action {
        case fetchTriggered
        case charactersFetched(IdentifiedArrayOf<Character>)
        case fetchFailed
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchTriggered:
                guard state.characters.isEmpty else { return .none }
                
                state.fetchFailed = false
                state.isLoading = true
                return .run { send in                    
                    do {
                        let characters = try await charactersService.fetch()
                        await send(.charactersFetched(characters))
                    } catch {
                        logger.error("Could not fetch characters: \(error)") // TODO: user error handling (manual retry)
                    }
                }
                
            case let .charactersFetched(characters):
                state.isLoading = false
                state.characters = characters
                return .none
                
            case .fetchFailed:
                state.isLoading = false
                state.fetchFailed = true
                return .none
            }
        }
    }
}



