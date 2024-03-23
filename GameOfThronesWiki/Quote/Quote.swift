//
//  Quote.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 23.03.24.
//

import Foundation

struct Quote: Codable {
    let sentence: String
    let character: QuoteCharacter
}

struct QuoteCharacter: Codable {
    let name: String
}
