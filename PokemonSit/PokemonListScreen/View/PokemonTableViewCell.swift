//
//  PokemonTableViewCell.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 30.01.23.
//

import UIKit

final class PokemonTableViewCell: UITableViewCell {
    @IBOutlet weak var pokeballImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setName(name: String) {
        nameLabel.text = name
    }
}
