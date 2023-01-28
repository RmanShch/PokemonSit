//
//  DataFetcherService.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 28.01.23.
//

import Foundation

class DataFetcherService {
    var dataFetcher: DataFetcher
    private var pokemonListURLString = "https://pokeapi.co/api/v2/pokemon"
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchAllPokemons(urlString: String, completion: @escaping (PokemonList?) -> Void) {
        
        dataFetcher.fetchJSONData(urlString: pokemonListURLString, completion: completion)
    }
    
}
