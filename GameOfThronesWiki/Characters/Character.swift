//
//  Character.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 23.03.24.
//

import Foundation

struct Character: Codable, Identifiable {
    let id: Int
    let firstName: String
    let lastName: String
    let fullName: String
    let title: String
    let family: String // TODO: extract to enum maybe?
    let image: String
    let imageUrl: String
}
