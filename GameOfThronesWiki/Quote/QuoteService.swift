//
//  QuoteService.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 23.03.24.
//

import ComposableArchitecture
import Foundation

struct QuoteService {
    /// Fetches a random quote by a random character
    var fetch: () async throws -> Quote
    
    /// Fetches a random quote by a given author
    var fetchForCharacterFirstName: (String) async throws -> Quote
}

//MARK: - Live Implementation -
extension QuoteService: DependencyKey {
    static let liveValue = Self(
        fetch: {
            guard let url = URL(string: "https://api.gameofthronesquotes.xyz/v1/random") else {
                throw URLError(.badURL)
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(Quote.self, from: data)
        }, fetchForCharacterFirstName: { characterFirstName in
            guard let url = URL(string: "https://api.gameofthronesquotes.xyz/v1/author/" + characterFirstName.lowercased()) else {
                throw URLError(.badURL)
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(Quote.self, from: data)
        }
    )
}

//MARK: - Preview Implementation -
extension QuoteService {
    static let previewValue = Self(
        fetch: {
            try? await Task.sleep(for: .seconds(1))
            
            return Quote(sentence: "Many underestimated you. Most of them are dead now.",
                         character: .init(name: "Tyrion Lannister"))
        }, fetchForCharacterFirstName: { characterFirstName in
            try? await Task.sleep(for: .seconds(1))
            
            return Quote(sentence: "Many underestimated you. Most of them are dead now.",
                         character: .init(name: characterFirstName))
        }
    )
}

//MARK: - Test Implementation -
extension QuoteService {
    static let testValue = Self(
        fetch: {
            return .init(sentence: "Sentence Test", character: .init(name:"Author Test"))
        }, fetchForCharacterFirstName: { characterFirstName in
            return .init(sentence: "Character Sentence Test", character: .init(name: characterFirstName))
        }
    )
}

extension DependencyValues {
    var quoteService: QuoteService {
        get { self[QuoteService.self] }
        set { self[QuoteService.self] = newValue }
    }
}

