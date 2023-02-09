//
//  PokemonPresenter.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 28.01.23.
//

import Foundation

final class PokemonPresenter {
    weak private var pokemonView: PokemonView?
    private var dataFetchService: DataFetcherService?
    private var reachabilityChecker: Reachability!
    private var persistenceManager: PersistenceManager?
    private var nextUrl: String?
    private var pokemons: [Pokemon] = []
    private var networkConnection = false
    
    func setDelegate(pokemonView: PokemonView) {
        self.pokemonView = pokemonView
        persistenceManager = UserDefaultsManager()
        dataFetchService = DataFetcherService(persistenceManager: persistenceManager!)
        reachabilityChecker = ReachabilityChecker()
    }
    
    func viewDidLoad() {
        if checkNetworkConnection() {
            fetchPokemons()
        } else {
            pokemonView?.showAlert(title: "No internet connection.", message: "Last saved data will be loaded")
        }
    }
    
    private func checkNetworkConnection() -> Bool {
        let isConnected = reachabilityChecker.isConnectedToNetwork()
        networkConnection = isConnected
        return isConnected
    }
    
    func fetchPokemons() {
        dataFetchService?.fetchPokemonList(fromNetwork: networkConnection, completion: { [weak self] pokemonList in
            guard let pokemons = pokemonList?.results else { return }
            self?.pokemons += pokemons
            self?.nextUrl = pokemonList?.next
            self?.pokemonView?.pokemonsLoaded(pokemons: pokemons)
        })
    }
    
    func pokemonSelected(pokemon: Pokemon) {
        networkConnection = reachabilityChecker.isConnectedToNetwork()
        let urlString = pokemon.url
        dataFetchService?.fetchPokemonInfo(fromNetwork: networkConnection, urlString: urlString) { [weak self] pokemon in
            guard let pokemon = pokemon,
                  let dataFetchService = self?.dataFetchService else { return }
            let name = pokemon.name
            let imageUrlString = pokemon.sprites.frontDefault
            let types: [String] = pokemon.types.map {
                $0.type.name
            }
            let weight = pokemon.weight
            let height = pokemon.height
            print(urlString)
            print("\(name.capitalized), weight - \(weight), height - \(height), type - \(types[0]) \n \(imageUrlString)")
            let presenter = PokemonDetailsPresenter(pokemon: pokemon, dataFetchService: dataFetchService)
            presenter.delegate = self
            self?.pokemonView?.setUpDetailsView(name: name, weight: weight, height: height, types: types, presenter: presenter)
        }
    }
    
    func loadMorePokemons() {
        networkConnection = reachabilityChecker.isConnectedToNetwork()
        guard let urlString = nextUrl else {
            print("no more pokemons")
            return }
        dataFetchService?.fetchMorePokemons(fromNetwork: networkConnection, urlString: urlString) { [weak self] pokemonList in
            guard let pokemons = pokemonList,
                  let pokemonsCountBeforeUpdate = self?.pokemons.count else { return }
            for i in 0...pokemons.results.count-1 {
                let indexPath = [IndexPath(row: i + pokemonsCountBeforeUpdate, section: 0)]
                let pokemon = pokemons.results[i]
                self?.pokemons.append(pokemon)
                self?.pokemonView?.pokemonLoaded(pokemon: pokemon, for: indexPath)
            }
            self?.pokemonView?.loadingFinished()
            self?.nextUrl = pokemonList?.next
        }
    }

}

extension PokemonPresenter: DetailPresenterDelegate {
    func checkConnection() -> Bool {
        return networkConnection
    }
}
