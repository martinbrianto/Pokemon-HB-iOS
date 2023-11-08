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
            return "By Name"
        case .types:
            return "By Types"
        case .evolvesFrom:
            return "By Evolves From"
        }
    }
    
    var searchBarPlaceholder: String {
        switch self {
        case .name:
            return "Search by name"
        case .types:
            return "Search by types"
        case .evolvesFrom:
            return "Search by evolves from"
        }
    }
    
    static var allCases: [PokemonCardSearchType] = [.name, .types, .evolvesFrom]
}
