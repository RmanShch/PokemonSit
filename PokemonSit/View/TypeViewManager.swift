//
//  TypeViewManager.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 31.01.23.
//

import Foundation
import UIKit

// Separated these hardcoded methods from presenter and detailsView

protocol ColorAndIconManager: AnyObject {
    func getColor(for typeName: String) -> UIColor
    func getIcon(for typeName: String) -> UIImage?
}

class TypeViewManager: ColorAndIconManager {
    func getColor(for typeName: String) -> UIColor {
        return chooseColor(for: typeName)
    }
    
    func getIcon(for typeName: String) -> UIImage? {
        let iconName = chooseIconName(for: typeName)
        let icon = UIImage(systemName: iconName)
        return icon
        
    }
    
    private func chooseColor(for typeName: String) -> UIColor {
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
    
    private func chooseIconName(for typeName: String) -> String {
        switch typeName {
        case "fighting": return "figure.boxing"
        case "normal": return "pawprint"
        case "flying": return "wind"
        case "ground": return "pawprint.fill"
        case "rock": return "mountain.2.fill"
        case "poison": return "drop.triangle.fill"
        case "bug": return "ladybug"
        case "ghost": return "aqi.medium"
        case "steel": return "gearshape.fill"
        case "fire": return "flame.fill"
        case "water": return "drop.fill"
        case "grass": return "leaf"
        case "electric": return "bolt"
        case "physic": return "cross.fill"
        case "ice": return "snow"
        case "dragon": return "hurricane.circle"
        case "dark": return "moonphase.full.moon"
        case "fairy": return "sparkles"
        default: return "pawprint"
        }
    }
    
    
}
