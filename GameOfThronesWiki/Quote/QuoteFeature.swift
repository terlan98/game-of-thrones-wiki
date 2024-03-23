//
//  QuoteFeature.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 23.03.24.
//

import ComposableArchitecture
import OSLog

// TODO: write tests
@Reducer
struct QuoteFeature {
    private var logger = Logger(subsystem: "GameOfThronesWiki", category: "QuoteFeature")
    @Dependency(\.quoteService) var quoteService
    
    @ObservableState
    struct State {
        var quote: Quote?
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
                
                return .run { send in
                    do {
                        let quote = try await quoteService.fetch()
                        await send(.quoteFetched(quote))
                    } catch {
                        logger.error("Could not fetch quote: \(error)") // TODO: user error handling (manual retry)
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
