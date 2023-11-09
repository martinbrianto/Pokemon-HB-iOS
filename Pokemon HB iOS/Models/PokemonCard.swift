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
    let images: PokemonCardImage
    let set: PokemonCardSet
    let cardmarket: PokemonCardMarket?
}

struct PokemonCardImage: Codable {
    let small: String
    let large: String
}

struct PokemonCardSet: Codable {
    let images: PokemonCardSetImage
}

struct PokemonCardSetImage: Codable {
    let logo: String
}

struct PokemonCardMarket: Codable {
    let url: String
    let updatedAt: String
    let prices: PokemonCardMarketPrice
}

struct PokemonCardMarketPrice: Codable {
    let lowPrice: Double
    let trendPrice: Double
    let avg1: Double
    let avg7: Double
    let avg30: Double
}
