//
//  JSONDecoder.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 30.01.23.
//

import Foundation

protocol GenericDecoder {
    func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T?
}

class JsonDecoder: GenericDecoder {
    
    func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let decodeError {
            print("Failed to decode JSON", decodeError)
            return nil
        }
    }
}
