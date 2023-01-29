//
//  PokemonDetailsPresenter.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 29.01.23.
//

import Foundation

protocol DetailsPresenter: AnyObject {
    func setDelegate(pokemonDetailsView: PokemonDetailsView)
    func viewDidLoad()
}

class PokemonDetailsPresenter: DetailsPresenter {
    weak private var pokemonDetailsView: PokemonDetailsView?
    let dataFetchService: DataFetcherService
    let pokemon: PokemonDetails
    
    init(pokemon: PokemonDetails, dataFetchService: DataFetcherService) {
        self.pokemon = pokemon
        self.dataFetchService = dataFetchService
    }
    
    func setDelegate(pokemonDetailsView: PokemonDetailsView) {
        self.pokemonDetailsView = pokemonDetailsView
    }
    
    func viewDidLoad() {
        let imageUrl = pokemon.sprites.frontDefault
        dataFetchService.fetchImage(urlString: imageUrl) { [weak self] imageData in
            guard let imageData = imageData else { return }
            self?.pokemonDetailsView?.setImage(with: imageData)
        }
    }
    
}
