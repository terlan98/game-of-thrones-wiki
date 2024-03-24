//
//  Character.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 23.03.24.
//

import Foundation

/// Represents a Game of Thrones character
struct Character: Codable, Identifiable, Equatable {
    let id: Int
    let firstName: String
    let lastName: String
    let fullName: String
    let title: String
    let family: House?
    let image: String
    let imageUrl: String
}
