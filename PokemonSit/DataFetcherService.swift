//
//  DataFetcherService.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 28.01.23.
//

import Foundation

class DataFetcherService {
    var dataFetcher: DataFetcher
    
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchPokemons(completion: @escaping (PokemonList?) -> Void) {
        let pokemonListURLString = "https://pokeapi.co/api/v2/pokemon"
        dataFetcher.fetchJSONData(urlString: pokemonListURLString, completion: completion)
    }
    
    func fetchMorePokemons(urlString: String, completion: @escaping (PokemonList?) -> Void) {
        
        dataFetcher.fetchJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchPokemonInfo(urlString: String, completion: @escaping (PokemonDetails?) -> Void) {
        dataFetcher.fetchJSONData(urlString: urlString, completion: completion)
    }
}
