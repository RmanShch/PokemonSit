//
//  ViewController.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 26.01.23.
//

import UIKit

protocol PokemonView: AnyObject {
    func pokemonsLoaded(pokemons: [Pokemon])
    
}

class PokemonListViewController: UIViewController, PokemonView {
    @IBOutlet weak var pokemonsTableView: UITableView!
    
    private var pokemonPresenter = PokemonPresenter()
    private var pokemons: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonPresenter.setDelegate(pokemonView: self)
        setUpTableView()
        pokemonPresenter.viewDidLoad()
    }
    
    private func setUpTableView() {
        pokemonsTableView.delegate = self
        pokemonsTableView.dataSource = self
    }
    
    
    
    func pokemonsLoaded(pokemons: [Pokemon]) {
        self.pokemons = pokemons
        pokemonsTableView.reloadData()
    }
}

extension PokemonListViewController: UITableViewDelegate {
    
}
extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pokemonsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let pokemon = pokemons[indexPath.row]
        let pokemonName = pokemon.name
        cell.textLabel?.text = pokemonName
        
        return cell
    }
    
    
}
