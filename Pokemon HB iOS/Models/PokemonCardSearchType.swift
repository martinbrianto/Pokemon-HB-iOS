//
//  PokemonCardSearchType.swift
//  Pokemon HB iOS
//
//  Created by Martin Brianto on 08/11/23.
//

import Foundation

enum PokemonCardSearchType {
    case name
    case types
    case evolvesFrom
    
    var searchParameter: String {
        switch self {
        case .name:
            return "name"
        case .types:
            return "types"
        case .evolvesFrom:
            return "evolvesFrom"
        }
    }
    
    var optionlabel: String {
        switch self {
        case .name:
            return "By pokemon name"
        case .types:
            return "By pokemon types"
        case .evolvesFrom:
            return "By pokemon evolves from"
        }
    }
    
    var searchBarPlaceholder: String {
        switch self {
        case .name:
            return "Search by pokemon name"
        case .types:
            return "Search by pokemon types"
        case .evolvesFrom:
            return "Search by pokemon evolves from"
        }
    }
    
    static var allCases: [PokemonCardSearchType] = [.name, .types, .evolvesFrom]
}
