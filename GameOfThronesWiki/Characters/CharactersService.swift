//
//  CharactersService.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 23.03.24.
//

import ComposableArchitecture
import Foundation

struct CharactersService {
    var fetch: () async throws -> IdentifiedArrayOf<Character>
}

//MARK: - Live Implementation -
extension CharactersService: DependencyKey {
    static let liveValue = Self(
        fetch: {
            guard let url = URL(string: "https://thronesapi.com/api/v2/Characters") else {
                throw URLError(.badURL)
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(IdentifiedArrayOf<Character>.self, from: data)
        }
    )
}

//MARK: - Preview Implementation -
extension CharactersService {
    static let previewValue = Self(
        fetch: {
            try? await Task.sleep(for: .seconds(1))
            
            let characters = [
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
                          imageUrl: "https://thronesapi.com/assets/images/sam.jpg"),
                Character(id: 2,
                          firstName: "Jon",
                          lastName: "Snow",
                          fullName: "Jon Snow",
                          title: "King of the North",
                          family: .stark,
                          image: "jon-snow.jpg",
                          imageUrl: "https://thronesapi.com/assets/images/jon-snow.jpg"),
                Character(id: 3,
                          firstName: "Arya",
                          lastName: "Stark",
                          fullName: "Arya Stark",
                          title: "No One",
                          family: .stark,
                          image: "arya-stark.jpg",
                          imageUrl: "https://thronesapi.com/assets/images/arya-stark.jpg"),
                Character(id: 4,
                          firstName: "Sansa",
                          lastName: "Stark",
                          fullName: "Sansa Stark",
                          title: "Lady of Winterfell",
                          family: .stark,
                          image: "sansa-stark.jpeg",
                          imageUrl: "https://thronesapi.com/assets/images/sansa-stark.jpeg"),
                Character(id: 5,
                          firstName: "Brandon",
                          lastName: "Stark",
                          fullName: "Brandon Stark",
                          title: "Lord of Winterfell",
                          family: .stark,
                          image: "bran-stark.jpg",
                          imageUrl: "https://thronesapi.com/assets/images/bran-stark.jpg"),
                Character(id: 6,
                          firstName: "Ned",
                          lastName: "Stark",
                          fullName: "Ned Stark",
                          title: "Lord of Winterfell",
                          family: .stark,
                          image: "ned-stark.jpg",
                          imageUrl: "https://thronesapi.com/assets/images/ned-stark.jpg"),
                Character(id: 7,
                          firstName: "Robert",
                          lastName: "Baratheon",
                          fullName: "Robert Baratheon",
                          title: "Lord of the Seven Kingdoms",
                          family: .baratheon,
                          image: "robert-baratheon.jpeg",
                          imageUrl: "https://thronesapi.com/assets/images/robert-baratheon.jpeg"),
            ] as IdentifiedArrayOf<Character>
            
            return characters
        }
    )
}

extension DependencyValues {
    var charactersService: CharactersService {
        get { self[CharactersService.self] }
        set { self[CharactersService.self] = newValue }
    }
}

