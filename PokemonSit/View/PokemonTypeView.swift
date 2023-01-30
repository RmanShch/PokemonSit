//
//  PokemonTypeView.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 30.01.23.
//

import Foundation
import UIKit

class PokemonTypeView: UIView {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 30, height: 30))
        imageView.image = UIImage(systemName: "flame")
        return imageView
    }()
    
    lazy var typeNameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 40, y: 5, width: 75, height: 30))
        
        label.font = UIFont(name: "Kohinoor Gujarati", size: 20.0)
        label.text = "fighting"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        addSubview(imageView)
        addSubview(typeNameLabel)
        layer.cornerRadius = 5
    }
    
    func setupColor(color: UIColor) {
        backgroundColor = color
    }
    
    func setupImage(imageName: String) {
        let image = UIImage(systemName: imageName)
        imageView.image = image
        imageView.tintColor = .black
    }
    
    func setupLabel(typeName: String) {
        typeNameLabel.text = typeName
    }
}
