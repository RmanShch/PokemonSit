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
    private var dataFetchService = DataFetcherService()
    var pokemon: PokemonDetails?
    
    func setDelegate(pokemonDetailsView: PokemonDetailsView) {
        self.pokemonDetailsView = pokemonDetailsView
    }
    
    func viewDidLoad() {
        guard let imageUrl = pokemon?.sprites.frontDefault else { return }
        dataFetchService.fetchImage(urlString: imageUrl) { [weak self] imageData in
            guard let imageData = imageData else { return }
            self?.pokemonDetailsView?.setImage(with: imageData)
        }
    }
    
}
