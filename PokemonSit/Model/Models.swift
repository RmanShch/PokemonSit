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

struct Pokemon: Decodable {
    let name: String
    let url: String
}

struct PokemonDetails: Decodable {
    let name: String
    let weight: Int
    let height: Int
    let types: [PokeType]
    let sprites: Sprites
}


struct PokeType: Decodable {
    let type: TypeInfo
}

struct TypeInfo: Decodable {
    let name: String
}

struct Sprites: Decodable {
    let backDefault: String
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case frontDefault = "front_default"
    }
}
