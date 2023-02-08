//
//  UserDefaultsManager.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 30.01.23.
//

import Foundation

protocol PersistenceManager {
    func saveData(data: Data?, for key: String)
    func getData(for key: String) -> Data?
    func deleteData(for key: String)
}

final class UserDefaultsManager: PersistenceManager {
    
    private let userDefaults = UserDefaults()
    
    func saveData(data: Data?, for key: String) {
        userDefaults.set(data, forKey: key)
    }
    
    func getData(for key: String) -> Data? {
        userDefaults.data(forKey: key)
    }
    
    func deleteData(for key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
}
