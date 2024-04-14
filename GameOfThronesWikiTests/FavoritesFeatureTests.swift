//
//  FavoritesFeatureTests.swift
//  GameOfThronesWikiTests
//
//  Created by Tarlan Ismayilsoy on 14.04.24.
//

import XCTest
import ComposableArchitecture
@testable import GameOfThronesWiki

@MainActor
final class FavoritesFeatureTests: XCTestCase {
    func testAddingFavorite() async {
        var dummyCharacter: Character {
            Character(id: 0,
                      firstName: "Daenerys",
                      lastName: "Targaryen",
                      fullName: "Daenerys Targaryen",
                      title: "Mother of Dragons",
                      family: .targaryen,
                      image: "daenerys.jpg",
                      imageUrl: "https://thronesapi.com/assets/images/daenerys.jpg")
        }
        
        let store = TestStore(initialState: FavoritesFeature.State()) {
            FavoritesFeature()
        } withDependencies: {
            $0.favoritesService.fetch = { [dummyCharacter] }
        }
        
        await store.send(.fetchFavorites) {
            $0.isLoading = true
        }
        
        await store.receive(\.favoritesFetched) {
            $0.isLoading = false
            $0.favorites = [dummyCharacter]
        }
        
        await store.receive(\.delegate)
    }
    
    func testRemovingFavorite() async {
        var dummyCharacter: Character {
            Character(id: 0,
                      firstName: "Daenerys",
                      lastName: "Targaryen",
                      fullName: "Daenerys Targaryen",
                      title: "Mother of Dragons",
                      family: .targaryen,
                      image: "daenerys.jpg",
                      imageUrl: "https://thronesapi.com/assets/images/daenerys.jpg")
        }
        
        let store = TestStore(initialState: FavoritesFeature.State()) {
            FavoritesFeature()
        } withDependencies: {
            $0.favoritesService.fetch = { [dummyCharacter] }
        }
        
        await store.send(.fetchFavorites) {
            $0.isLoading = true
        }
        
        await store.receive(\.favoritesFetched) {
            $0.isLoading = false
            $0.favorites = [dummyCharacter]
        }
        
        await store.receive(\.delegate)
        
        await store.send(.toggleFavorite(dummyCharacter))
        
        await store.receive(\.favoritesFetched) {
            $0.favorites = []
        }
        
        await store.receive(\.delegate)
    }
}
