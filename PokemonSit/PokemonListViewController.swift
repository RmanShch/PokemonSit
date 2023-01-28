//
//  ViewController.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 26.01.23.
//

import UIKit

class PokemonListViewController: UIViewController, PokemonPresenterDelegate {
    
    private var pokemonPresenter = PokemonPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonPresenter.setDelegate(pokemonPresenterDelegate: self)
    }


}

