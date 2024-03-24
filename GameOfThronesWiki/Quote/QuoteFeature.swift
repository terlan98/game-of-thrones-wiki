//
//  QuoteFeature.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 23.03.24.
//

import ComposableArchitecture
import OSLog

@Reducer
struct QuoteFeature {
    private var logger = Logger(subsystem: "GameOfThronesWiki", category: "QuoteFeature")
    @Dependency(\.quoteService) var quoteService
    
    @ObservableState
    struct State: Equatable {
        var quote: Quote?
        var character: Character?
        var isLoading = false
        var fetchFailed = false
    }
    
    enum Action {
        case fetchTriggered
        case quoteFetched(Quote)
        case fetchFailed
        case reset
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchTriggered:
                guard state.quote == nil else { return .none }
                
                state.fetchFailed = false
                state.isLoading = true
                
                return .run { [character = state.character] send in
                    do {
                        let quote: Quote
                        
                        if let characterFirstName = character?.firstName {
                            quote = try await quoteService.fetchForCharacterFirstName(characterFirstName)
                        } else {
                            quote = try await quoteService.fetch()
                        }
                        await send(.quoteFetched(quote))
                    } catch {
                        logger.error("Could not fetch quote: \(error)")
                        await send(.fetchFailed)
                    }
                }
                
            case let .quoteFetched(quote):
                state.isLoading = false
                state.quote = quote
                return .none
            
            case .fetchFailed:
                state.isLoading = false
                state.fetchFailed = true
                return .none
                
            case .reset:
                state.quote = nil
                state.isLoading = false
                state.fetchFailed = false
                return .none
            }
        }
    }
}
