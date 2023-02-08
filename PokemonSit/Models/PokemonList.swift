//
//  Models.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 28.01.23.
//

import Foundation

struct PokemonList: Decodable {
    let count: Int
    let next: String?
    let results: [Pokemon]
}
