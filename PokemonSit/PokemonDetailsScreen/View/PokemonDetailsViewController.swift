//
//  PokemonDetailsViewController.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 29.01.23.
//

import UIKit

protocol PokemonDetailsView: AnyObject {
    func setImage(with imageData: Data?)
}

final class PokemonDetailsViewController: UIViewController, PokemonDetailsView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var firstTypeContainer: UIView!
    @IBOutlet weak var secondTypeContainer: UIView!
    
    var presenter: DetailsPresenter?
    
    var name: String?
    var weight: Int?
    var height: Int?
    var types: [String]?
    var imageUrl: String?
    var imageData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.setDelegate(pokemonDetailsView: self)
        presenter?.viewDidLoad()
        setSubviews()
        navigationItem.title = name
    }
    
    private func setSubviews() {
        nameLabel.text = name
        weightLabel.text = "Weight: \(String(describing: weight ?? 0))"
        heightLabel.text = "Height: \(String(describing: height ?? 0))"
        guard let types = types else { return }
        let typeViewsContainers = [firstTypeContainer, secondTypeContainer]
        for i in 0...types.count-1 {
            guard i < typeViewsContainers.count else { return }
            let typeView = PokemonTypeView(frame: typeViewsContainers[i]!.frame)
            typeView.setupColor(for: types[i])
            typeView.setupImage(for: types[i])
            typeView.setupLabel(for: types[i])
            view.addSubview(typeView)
        }
        
        guard let imageData = imageData else { return }
        let image = UIImage(data: imageData)
        imageView.image = image
        }
    
    func setImage(with imageData: Data?) {
        guard let data = imageData else { return }
        let image = UIImage(data: data)
        imageView.image = image
    }
}
