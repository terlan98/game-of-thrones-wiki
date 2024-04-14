//
//  CharactersFeatureTests.swift
//  GameOfThronesWikiTests
//
//  Created by Tarlan Ismayilsoy on 24.03.24.
//

import XCTest
import ComposableArchitecture
@testable import GameOfThronesWiki

@MainActor
final class CharactersFeatureTests: XCTestCase {
    func testFetchingCharacters() async {
        var dummyCharacters: IdentifiedArrayOf<Character> { 
            [
                Character(id: 0,
                          firstName: "Daenerys",
                          lastName: "Targaryen",
                          fullName: "Daenerys Targaryen",
                          title: "Mother of Dragons",
                          family: .targaryen,
                          image: "daenerys.jpg",
                          imageUrl: "https://thronesapi.com/assets/images/daenerys.jpg"),
                Character(id: 1,
                          firstName: "Samwell",
                          lastName: "Tarly",
                          fullName: "Samwell Tarly",
                          title: "Maester",
                          family: .tarly,
                          image: "sam.jpg",
                          imageUrl: "https://thronesapi.com/assets/images/sam.jpg")
            ]
        }
        
        let store = TestStore(initialState: CharactersFeature.State()) {
            CharactersFeature()
        } withDependencies: {
            $0.charactersService.fetch = { dummyCharacters }
        }
        
        await store.send(.fetchTriggered) {
            $0.isLoading = true
        }
        
        await store.receive(\.charactersFetched) {
            $0.isLoading = false
            $0.characters = dummyCharacters
        }
    }
    
    func testFetchingCharactersFailure() async {
        let store = TestStore(initialState: CharactersFeature.State()) {
            CharactersFeature()
        } withDependencies: {
            $0.charactersService.fetch = { throw URLError(.badURL) }
        }
        
        await store.send(.fetchTriggered) {
            $0.isLoading = true
        }
        
        await store.receive(\.fetchFailed) {
            $0.isLoading = false
            $0.fetchFailed = true
            $0.characters = []
        }
    }
}
