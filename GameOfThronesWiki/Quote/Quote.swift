//
//  Quote.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 23.03.24.
//

import Foundation

struct Quote: Codable, Equatable {
    let sentence: String
    let character: QuoteCharacter
}

struct QuoteCharacter: Codable, Equatable {
    let name: String
}
