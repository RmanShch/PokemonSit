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

class PokemonDetailsViewController: UIViewController, PokemonDetailsView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    weak var presenter: DetailsPresenter?
    
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
    }
    
    func setSubviews() {
        nameLabel.text = name
        weightLabel.text = "Weight: \(String(describing: weight))"
        heightLabel.text = "Height: \(String(describing: height))"
        var typeLabelText = "Type: \n"
        guard let types = types else { return }
        for type in types {
            typeLabelText += type + "\n"
        }
        
        //typeLabel.text = typeLabelText
        
        guard let imageData = imageData else { return }
        let image = UIImage(data: imageData)
        imageView.image = image
        
        //imageView.image = pokemonImage
    }
    
    func setImage(with imageData: Data?) {
        guard let data = imageData else { return }
        let image = UIImage(data: data)
        imageView.image = image
    }
    
}
