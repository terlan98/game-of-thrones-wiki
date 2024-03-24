//
//  CharacterDetailFeature.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 24.03.24.
//

import ComposableArchitecture

@Reducer
struct CharacterDetailFeature {
    @ObservableState
    struct State: Equatable {
        let character: Character
        var quote = QuoteFeature.State()
    }
    
    enum Action {
        case quote(QuoteFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.quote, action: \.quote) {
            QuoteFeature()
        }
        
        Reduce { state, action in
            return .none
//            switch action {
//                
//            }
        }
    }
}


