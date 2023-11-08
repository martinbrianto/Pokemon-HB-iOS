//
//  PokemonCard.swift
//  Pokemon HB iOS
//
//  Created by Martin Brianto on 08/11/23.
//

import Foundation

struct PokemonCard: Codable {
    let id: String
    let name: String
    let images: PokemonCardImages
    let set: PokemonCardSet
}

struct PokemonCardImages: Codable {
    let small: String
    let large: String
}

struct PokemonCardSet: Codable {
    let images: PokemonCardSetImages
}

struct PokemonCardSetImages: Codable {
    let logo: String
}
