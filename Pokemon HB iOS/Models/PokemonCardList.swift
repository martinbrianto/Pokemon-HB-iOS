//
//  PokemonCardList.swift
//  Pokemon HB iOS
//
//  Created by Martin Brianto on 08/11/23.
//

import Foundation

struct PokemonCardList: Codable {
    let data: [PokemonCard]
    let page: Int
    let pageSize: Int
    let count: Int
    let totalCount: Int
}
