//
//  Sprites.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 7.02.23.
//

import Foundation

struct Sprites: Decodable {
    let backDefault: String
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case frontDefault = "front_default"
    }
}
