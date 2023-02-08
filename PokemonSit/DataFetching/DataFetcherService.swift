//
//  DataFetcherService.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 28.01.23.
//

import Foundation

final class DataFetcherService {
    private var decoder: GenericDecoder
    private var persistenceManager: PersistenceManager
    private var networkService: Networking
    
    
    init(persistenceManager:PersistenceManager, decoder: GenericDecoder = JsonDecoder(), networkService: Networking = NetworkService()) {
        self.persistenceManager = persistenceManager
        self.decoder = decoder
        self.networkService = networkService
    }
    
    func fetchPokemonList(fromNetwork: Bool, completion: @escaping (PokemonList?) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon"
        //if dataSource {
        if fromNetwork {
            networkService.request(urlString: urlString) { [weak self] data, error in
                if let error = error {
                    print("Error recieved requesting data: \(error.localizedDescription)")
                    completion(nil)
                }
                self?.persistenceManager.saveData(data: data, for: urlString)
                let decoded = self?.decoder.decodeJSON(type: PokemonList.self, from: data)
                completion(decoded)
            }
        } else {
            let data = persistenceManager.getData(for: "https://pokeapi.co/api/v2/pokemon")
            let decoded = decoder.decodeJSON(type: PokemonList.self, from: data)
            completion(decoded)
        }
    }
    
    func fetchMorePokemons(fromNetwork: Bool, urlString: String, completion: @escaping (PokemonList?) -> Void) {
        if fromNetwork {
            networkService.request(urlString: urlString) { [weak self] data, error in
                if let error = error {
                    print("Error recieved requesting data: \(error.localizedDescription)")
                    completion(nil)
                }
                self?.persistenceManager.saveData(data: data, for: urlString)
                let decoded = self?.decoder.decodeJSON(type: PokemonList.self, from: data)
                completion(decoded)
            }
        } else {
            let data = persistenceManager.getData(for: urlString)
            let decoded = decoder.decodeJSON(type: PokemonList.self, from: data)
            completion(decoded)
        }
    }
    
    func fetchPokemonInfo(fromNetwork: Bool, urlString: String, completion: @escaping (PokemonDetails?) -> Void) {
        if fromNetwork {
            networkService.request(urlString: urlString) { [weak self] data, error in
                if let error = error {
                    print("Error recieved requesting data: \(error.localizedDescription)")
                    completion(nil)
                }
                self?.persistenceManager.saveData(data: data, for: urlString)
                let decoded = self?.decoder.decodeJSON(type: PokemonDetails.self, from: data)
                completion(decoded)
            }
        } else {
            let data = persistenceManager.getData(for: urlString)
            let decoded = decoder.decodeJSON(type: PokemonDetails.self, from: data)
            completion(decoded)
        }
    }
    
    func fetchImage(fromNetwork: Bool, urlString: String, completion: @escaping (Data?) -> Void) {
        if fromNetwork {
            networkService.request(urlString: urlString) { [weak self] data, error in
                if let error = error {
                    print("Error recieved requesting data: \(error.localizedDescription)")
                    completion(nil)
                }
                self?.persistenceManager.saveData(data: data, for: urlString)
                completion(data)
            }
        } else {
            let data = persistenceManager.getData(for: urlString)
            completion(data)
        }
    }
}
