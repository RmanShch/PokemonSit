//
//  PokemonPresenter.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 28.01.23.
//

import Foundation

protocol Presenter {
    
}

class PokemonPresenter: Presenter {
    weak private var pokemonView: PokemonView?
    private var dataFetchService = DataFetcherService()
    //private var pokemons: [Pokemon] = []
    
    
    func setDelegate(pokemonView: PokemonView?) {
        self.pokemonView = pokemonView
    }
    
    func viewDidLoad() {
        dataFetchService.fetchAllPokemons(urlString: "") { [weak self] pokemonList in
            guard let pokemons = pokemonList?.results else { return }
            //self.pokemons += pokemons
            self?.pokemonView?.pokemonsLoaded(pokemons: pokemons)
        }
    }
    
}
