//
//  GameOfThronesWikiApp.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 22.03.24.
//

import SwiftUI
import ComposableArchitecture

@main
struct GameOfThronesWikiApp: App {
    static let store = Store(initialState: TabFeature.State()) {
        TabFeature()
//            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(store: Self.store)
        }
    }
}
