//
//  PokemonPresenter.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 28.01.23.
//

import Foundation

class PokemonPresenter {
    weak private var pokemonPresenterDelegate: PokemonPresenterDelegate?
    
    func setDelegate(pokemonPresenterDelegate: PokemonPresenterDelegate?) {
        self.pokemonPresenterDelegate = pokemonPresenterDelegate
    }
    
    
}
