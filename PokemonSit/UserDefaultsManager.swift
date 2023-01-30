//
//  UserDefaultsManager.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 30.01.23.
//

import Foundation

class UserDefaultsManager {
    
    let userDefaults = UserDefaults()
    
    func saveData(data: Data, for key: String) {
        userDefaults.set(data, forKey: key)
    }
    
    func getData(for key: String) {
        userDefaults.object(forKey: key)
    }
    
    func deleteData(for key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
}
