//
//  ViewController.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 26.01.23.
//

import UIKit

protocol PokemonView: AnyObject {
    func pokemonsLoaded(pokemons: [Pokemon])
    func pokemonLoaded(pokemon: Pokemon, for indexPath: [IndexPath])
    func loadingFinished()
    func setUpDetailsView(name: String, weight: Int, height: Int, types: [String], presenter: PokemonDetailsPresenter)
}

class PokemonListViewController: UIViewController, PokemonView {
    @IBOutlet weak var pokemonsTableView: UITableView!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    private var pokemonPresenter = PokemonPresenter()
    private var pokemons: [Pokemon] = []
    private var isLoading = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatorView.startAnimating()
        pokemonPresenter.setDelegate(pokemonView: self)
        setUpTableView()
        pokemonPresenter.viewDidLoad()
        setUpNavigationBar()
    }
    
    private func setUpTableView() {
        pokemonsTableView.delegate = self
        pokemonsTableView.dataSource = self
        pokemonsTableView.alpha = 0
    }
    
    private func setUpNavigationBar() {
        //navigationController?.navigationBar.largeContentTitle = "Pokemons"
    }
    
    func pokemonsLoaded(pokemons: [Pokemon]) {
        self.pokemons = pokemons
//        activityIndicatorView.stopAnimating()
        UIView.animate(withDuration: 0.3) {
            self.activityIndicatorView.stopAnimating()
            self.pokemonsTableView.reloadData()
            self.pokemonsTableView.alpha = 1
        }
        //pokemonsTableView.reloadData()
    }
    
    func pokemonLoaded(pokemon: Pokemon, for indexPath: [IndexPath]) {
        self.pokemons.append(pokemon)
        pokemonsTableView.insertRows(at: indexPath, with: .fade)
    }
    
    func loadingFinished() {
        isLoading = false
        activityIndicatorView.stopAnimating()
    }
    
    func setUpDetailsView(name: String, weight: Int, height: Int, types: [String], presenter: PokemonDetailsPresenter) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let pokemonDetailsViewController = storyboard.instantiateViewController(identifier: "PokemonDetailsVC") as PokemonDetailsViewController
//        guard let detailsVC = pokemonDetailsViewController as? PokemonDetailsViewController else { return }
        
        pokemonDetailsViewController.name = name.capitalized
        pokemonDetailsViewController.weight = weight
        pokemonDetailsViewController.height = height
        pokemonDetailsViewController.types = types
        pokemonDetailsViewController.presenter = presenter
        navigationController?.pushViewController(pokemonDetailsViewController, animated: true)
    }
}

extension PokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokemonPresenter.pokemonSelected(pokemon: pokemons[indexPath.row])
    }
    
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

extension PokemonListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let myHeight = scrollView.frame.height - 100
        
        guard !isLoading else { return }
        if offsetY > (contentHeight - myHeight) {
            isLoading = true
            activityIndicatorView.startAnimating()
            pokemonPresenter.loadMorePokemons()
        }
    }
}
