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
    
    func setSubviews() {
        nameLabel.text = name
        weightLabel.text = "Weight: \(String(describing: weight ?? 0))"
        heightLabel.text = "Height: \(String(describing: height ?? 0))"
        guard let types = types else { return }
        let typeViewsContainers = [firstTypeContainer, secondTypeContainer]
        for i in 0...types.count-1 {
            guard i < typeViewsContainers.count else { return }
            let typeView = PokemonTypeView(frame: typeViewsContainers[i]!.frame)
            let color = chooseColor(for: types[i])
            typeView.setupColor(color: color)
            guard let iconName = presenter?.chooseTypeIcon(for: types[i]) else { return }
            typeView.setupImage(imageName: iconName)
            typeView.setupLabel(typeName: types[i])
            view.addSubview(typeView)
        }
        
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
    
    func chooseColor(for typeName: String) -> UIColor {
        switch typeName {
        case "fighting": return .red
        case "normal": return .systemGray3
        case "flying": return .systemTeal
        case "ground": return .systemBrown
        case "rock": return .systemGray
        case "poison": return .systemPurple
        case "bug": return .green
        case "ghost": return .systemIndigo
        case "steel": return .systemGray2
        case "fire": return .systemOrange
        case "water": return .systemBlue
        case "grass": return .systemGreen
        case "electric": return .systemYellow
        case "physic": return .systemCyan
        case "ice": return .systemMint
        case "dragon": return .systemRed
        case "dark": return .systemGray
        case "fairy": return .systemPink
        default: return .systemGray3
        }
    }
}
