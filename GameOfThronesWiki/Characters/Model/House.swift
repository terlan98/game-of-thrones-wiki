//
//  House.swift
//  GameOfThronesWiki
//
//  Created by Tarlan Ismayilsoy on 24.03.24.
//

import Foundation

/// Represents a Game of Thrones house. May contain typos and repetitions due to API-related problems.
enum House: String {
    case targaryen = "House Targaryen"
    case targaryan = "Targaryan" // API typo
    case tarly = "House Tarly"
    case houseStark = "House Stark"
    case stark = "Stark"
    case houseBaratheon = "House Baratheon"
    case baratheon = "Baratheon"
    case houseLannister = "House Lannister"
    case houseLanister = "House Lanister" // API typo
    case lannister = "Lannister"
    case houseGreyjoy = "House Greyjoy"
    case greyjoy = "Greyjoy"
    case clegane = "House Clegane"
    case baelish = "House Baelish"
    case seaworth = "House Seaworth"
    case freeFolk = "Free Folk"
    case tarth = "Tarth"
    case naathi = "Naathi"
    case mormont = "Mormont"
    case bolton = "Bolton"
    case naharis = "Naharis"
    case lorathi = "Lorathi"
    case viper = "Viper"
    case sparrow = "Sparrow"
    case lorath = "Lorath"
    case sand = "Sand"
    case houseTyrell = "House Tyrell"
    case tyrell = "Tyrell"
    case worm = "Worm"
    case qyburn = "Qyburn"
    case bronn = "Bronn"
    
    case unknown = "Unknown"
    case unkown = "Unkown" // API typo
    case none = "None"
    case blank = ""
}

extension House {
    var iconName: String? {
        switch self {
        case .stark, .houseStark:
            "stark"
        case .greyjoy, .houseGreyjoy:
            "greyjoy"
        case .targaryen, .targaryan:
            "targaryen"
        case .houseLanister, .lannister, .houseLannister:
            "lannister"
        case .tyrell, .houseTyrell:
            "tyrell"
        case .baratheon, .houseBaratheon:
            "baratheon"
        default:
            nil
        }
    }
}

extension House: Codable {
    init(from decoder: Decoder) throws {
        guard let value = try? decoder.singleValueContainer().decode(String.self) else{
            self = .unknown
            return
        }
        self = House(rawValue: value) ?? .unknown
    }
}
