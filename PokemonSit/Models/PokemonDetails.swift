//
//  PokemonDetails.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 7.02.23.
//

import Foundation

struct PokemonDetails: Decodable {
    let name: String
    let weight: Int
    let height: Int
    let types: [PokeType]
    let sprites: Sprites
}
