//
//  PokemonDetailsPresenter.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 29.01.23.
//

import Foundation

protocol DetailPresenterDelegate: AnyObject {
    func checkConnection() -> Bool
}

protocol DetailsPresenter: AnyObject {
    func setDelegate(pokemonDetailsView: PokemonDetailsView)
    func viewDidLoad()
}

final class PokemonDetailsPresenter: DetailsPresenter {
    weak private var pokemonDetailsView: PokemonDetailsView?
    private let dataFetchService: DataFetcherService
    private let pokemon: PokemonDetails
    weak var delegate: DetailPresenterDelegate?
    
    init(pokemon: PokemonDetails, dataFetchService: DataFetcherService) {
        self.pokemon = pokemon
        self.dataFetchService = dataFetchService
    }
    
    func setDelegate(pokemonDetailsView: PokemonDetailsView) {
        self.pokemonDetailsView = pokemonDetailsView
    }
    
    func viewDidLoad() {
        guard let networkConnection = delegate?.checkConnection() else { return }
        let imageUrl = pokemon.sprites.frontDefault
        dataFetchService.fetchImage(fromNetwork: networkConnection, urlString: imageUrl) { [weak self] imageData in
            guard let imageData = imageData else { return }
            self?.pokemonDetailsView?.setImage(with: imageData)
        }
    }
}
