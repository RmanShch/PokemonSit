//
//  NetworkDataFetcher.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 28.01.23.
//

import Foundation

protocol DataFetcher {
    func fetchJSONData<T: Decodable>(urlString: String, completion: @escaping (T?) -> Void)
}

class NetworkDataFetcher: DataFetcher {
    
    var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func fetchJSONData<T: Decodable>(urlString: String, completion: @escaping (T?) -> Void) {
        networking.request(urlString: urlString) { [weak self] data, error in
            if let error = error {
                print("Error recieved requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decoded = self?.decodeJSON(type: T.self, from: data)
            completion(decoded)
        }
    }
    
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
