//
//  PokemonDetailsViewController.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 29.01.23.
//

import UIKit

protocol PokemonDetailsVCDelegate: AnyObject {
    
}

class PokemonDetailsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    weak var delegate: PokemonDetailsVCDelegate?
    weak var presenter: Presenter?
    
    var name: String?
    var weight: Int?
    var height: Int?
    var types: [String]?
    var imageUrl: String?
    var image: UIImage?
    
//    init(name: String, weight: Int, height: Int, types: [String], image: UIImage?) {
////        self.name = name
////        self.weight = weight
////        self.height = height
////        self.types = types
////        self.image = image
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("initialization failed with error")
//    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSubviews()
    }
    
    func setUpSubviews() {
        nameLabel.text = name
        weightLabel.text = "Weight: \(String(describing: weight))"
        heightLabel.text = "Height: \(String(describing: height))"
        var typeLabelText = "Type: \n"
        guard let types = types else { return }
        for type in types {
            typeLabelText += type + "\n"
        }
        
        //typeLabel.text = typeLabelText
        
        guard let pokemonImage = image else { return }
        //imageView.image = pokemonImage
    }
    
}
