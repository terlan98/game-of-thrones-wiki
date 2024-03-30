//
//  FavoritesService.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 25.03.24.
//

import ComposableArchitecture
import Foundation

struct FavoritesService {
    static let userDefaults = UserDefaults.standard
    static let userDefaultsKey = "favorites"
    
    var save: (IdentifiedArrayOf<Character>) -> ()
    var add: (Character) -> IdentifiedArrayOf<Character>
    var remove: (Character) -> IdentifiedArrayOf<Character>
    var fetch: () -> IdentifiedArrayOf<Character>
}

enum FavoritesServiceError: Error {
    case fetchFailed
}

//MARK: - Live Implementation -
extension FavoritesService: DependencyKey {
    static let liveValue = Self(
        save: { characters in
            saveToUserDefaults(favorites: characters)
        },
        add: { character in
            if var favorites = Self.fetchFromUserDefaults() {
                favorites.append(character)
                saveToUserDefaults(favorites: favorites)
                return favorites
            } else {
                saveToUserDefaults(favorites: [character])
                return [character]
            }
        },
        remove:  { character in
            if var favorites = Self.fetchFromUserDefaults() {
                favorites.removeAll(where: { $0.id == character.id })
                saveToUserDefaults(favorites: favorites)
                return favorites
            }
            return []
        },
        fetch: {
            return Self.fetchFromUserDefaults() ?? []
        }
    )
    
    static func saveToUserDefaults(favorites: IdentifiedArrayOf<Character>) {
        guard let data = try? JSONEncoder().encode(favorites) else {
            return
        }
        Self.userDefaults.set(data, forKey: Self.userDefaultsKey)
    }
    
    static func fetchFromUserDefaults() -> IdentifiedArrayOf<Character>? {
        guard let data = Self.userDefaults.data(forKey: Self.userDefaultsKey) else {
            return nil
        }
        return try? JSONDecoder().decode(IdentifiedArrayOf<Character>.self, from: data)
    }
}

//MARK: - Preview Implementation -
extension FavoritesService {
    static var previewFavorites: IdentifiedArrayOf<Character> = []
    static let previewValue = Self(
        save: { characters in
            previewFavorites.append(contentsOf: characters)
        },
        add: { character in
            previewFavorites.append(character)
            return previewFavorites
        },
        remove: { character in
            previewFavorites.remove(character)
            return previewFavorites
        },
        fetch: {
            return [
                Character(id: 2,
                          firstName: "Jon",
                          lastName: "Snow",
                          fullName: "Jon Snow",
                          title: "King of the North",
                          family: .stark,
                          image: "jon-snow.jpg",
                          imageUrl: "https://thronesapi.com/assets/images/jon-snow.jpg"),
                Character(id: 4,
                          firstName: "Sansa",
                          lastName: "Stark",
                          fullName: "Sansa Stark",
                          title: "Lady of Winterfell",
                          family: .stark,
                          image: "sansa-stark.jpeg",
                          imageUrl: "https://thronesapi.com/assets/images/sansa-stark.jpeg"),
                Character(id: 6,
                          firstName: "Ned",
                          lastName: "Stark",
                          fullName: "Ned Stark",
                          title: "Lord of Winterfell",
                          family: .stark,
                          image: "ned-stark.jpg",
                          imageUrl: "https://thronesapi.com/assets/images/ned-stark.jpg"),
            ] as IdentifiedArrayOf<Character>
        }
    )
}

extension DependencyValues {
    var favoritesService: FavoritesService {
        get { self[FavoritesService.self] }
        set { self[FavoritesService.self] = newValue }
    }
}
