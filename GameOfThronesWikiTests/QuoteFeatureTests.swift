//
//  QuoteFeatureTests.swift
//  GameOfThronesWikiTests
//
//  Created by Tarlan Ismayilsoy on 24.03.24.
//

import XCTest
import ComposableArchitecture
@testable import GameOfThronesWiki

@MainActor
final class QuoteFeatureTests: XCTestCase {
    
    /// Tests whether fetching a quote succeeds
    func testFetchingQuote() async {
        let dummyQuote = Quote(sentence: "Test", character: .init(name: "Author"))
        
        let store = TestStore(initialState: QuoteFeature.State()) {
            QuoteFeature()
        } withDependencies: {
            $0.quoteService.fetch = { dummyQuote }
        }
        
        await store.send(\.fetchTriggered) {
            $0.isLoading = true
        }
        
        await store.receive(\.quoteFetched) {
            $0.isLoading = false
            $0.quote = dummyQuote
        }
    }
    
    /// Tests whether resetting the state with an existing quote and then fetching a new one succeeds
    func testResetAndFetch() async {
        let dummyQuoteOne = Quote(sentence: "Test 1", character: .init(name: "Author 1"))
        let dummyQuoteTwo = Quote(sentence: "Test 2", character: .init(name: "Author 2"))
        
        let store = TestStore(initialState: QuoteFeature.State(quote: dummyQuoteOne)) {
            QuoteFeature()
        } withDependencies: {
            $0.quoteService.fetch = { dummyQuoteTwo }
        }
        
        store.assert {
            $0.quote = dummyQuoteOne
        }
        
        await store.send(\.reset) {
            $0.quote = nil
        }
        
        await store.send(\.fetchTriggered) {
            $0.isLoading = true
        }
        
        await store.receive(\.quoteFetched) {
            $0.isLoading = false
            $0.quote = dummyQuoteTwo
        }
    }
    
    /// Tests whether the failure of fetching a quote is handled correctly
    func testFetchingQuoteFailure() async {
        let store = TestStore(initialState: QuoteFeature.State()) {
            QuoteFeature()
        } withDependencies: {
            $0.quoteService.fetch = { throw URLError(.cancelled) }
        }
        
        await store.send(\.fetchTriggered) {
            $0.isLoading = true
        }
        
        await store.receive(\.fetchFailed) {
            $0.isLoading = false
            $0.fetchFailed = true
            $0.quote = nil
        }
    }
}
