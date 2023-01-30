//
//  PokemonPresenter.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 28.01.23.
//

import Foundation

protocol Presenter: AnyObject {
    func pokemonSelected(pokemon: Pokemon)
    
}

class PokemonPresenter: Presenter {
    weak private var pokemonView: PokemonView?
    private var dataFetchService = DataFetcherService()
    private var nextUrl: String?
    private var pokemons: [Pokemon] = []
    
    
    func setDelegate(pokemonView: PokemonView) {
        self.pokemonView = pokemonView
    }
    
    func viewDidLoad() {
        dataFetchService.fetchPokemons() { [weak self] pokemonList in
            guard let pokemons = pokemonList?.results else { return }
            self?.pokemons += pokemons
            self?.nextUrl = pokemonList?.next
            self?.pokemonView?.pokemonsLoaded(pokemons: pokemons)
            
        }
    }
    
    func pokemonSelected(pokemon: Pokemon) {
        let urlString = pokemon.url
        dataFetchService.fetchPokemonInfo(urlString: urlString) { [weak self] pokemon in
            guard let pokemon = pokemon else { return }
            let name = pokemon.name
            let imageUrlString = pokemon.sprites.frontDefault
            var types: [String] = []
            for type in pokemon.types {
                types.append(type.type.name)
            }
            let weight = pokemon.weight
            let height = pokemon.height
            print(urlString)
            print("\(name.capitalized), weight - \(weight), height - \(height), type - \(types[0]) \n \(imageUrlString)")
            let presenter = PokemonDetailsPresenter(pokemon: pokemon, dataFetchService: (self?.dataFetchService)!)
            self?.pokemonView?.setUpDetailsView(name: name, weight: weight, height: height, types: types, presenter: presenter)
        }
    }
    
    
    
    func loadMorePokemons() {
        guard let urlString = nextUrl else {
            print("no more pokemons")
            return }
        dataFetchService.fetchMorePokemons(urlString: urlString) { [weak self] pokemonList in
            let pokemonsCountBeforeUpdate = self?.pokemons.count
            guard let pokemons = pokemonList else { return }
            for i in 0...pokemons.results.count-1 {
                let indexPath = [IndexPath(row: i + pokemonsCountBeforeUpdate!, section: 0)]
                let pokemon = pokemons.results[i]
                self?.pokemons.append(pokemon)
                self?.pokemonView?.pokemonLoaded(pokemon: pokemon, for: indexPath)
            }
            self?.pokemonView?.loadingFinished()
            self?.nextUrl = pokemonList?.next
            print(self?.pokemons.count)
        }
    }

}
