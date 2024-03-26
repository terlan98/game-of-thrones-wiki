//
//  TabFeature.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 23.03.24.
//

import ComposableArchitecture

@Reducer
struct TabFeature {
    struct State: Equatable {
        var tab1 = CharactersFeature.State()
        var tab2 = FavoritesFeature.State()
    }
    
    enum Action {
        case tab1(CharactersFeature.Action)
        case tab2(FavoritesFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.tab1, action: \.tab1) {
            CharactersFeature()
        }
        Scope(state: \.tab2, action: \.tab2) {
            FavoritesFeature()
        }
        Reduce { state, action in
            return .none
        }
    }
}
