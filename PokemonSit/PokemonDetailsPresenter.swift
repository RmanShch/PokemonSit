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
    func chooseTypeIcon(for typeName: String) -> String
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
    
    func chooseTypeIcon(for typeName: String) -> String {
        switch typeName {
        case "fighting": return "figure.boxing"
        case "normal": return "pawprint"
        case "flying": return "wind"
        case "ground": return "pawprint.fill"
        case "rock": return "mountain.2.fill"
        case "poison": return "drop.triangle.fill"
        case "bug": return "ladybug"
        case "ghost": return "aqi.medium"
        case "steel": return "gearshape.fill"
        case "fire": return "flame.fill"
        case "water": return "drop.fill"
        case "grass": return "leaf"
        case "electric": return "bolt"
        case "physic": return "cross.fill"
        case "ice": return "snow"
        case "dragon": return "hurricane.circle"
        case "dark": return "moonphase.full.moon"
        case "fairy": return "sparkles"
        default: return "pawprint"
        }
    }
}
