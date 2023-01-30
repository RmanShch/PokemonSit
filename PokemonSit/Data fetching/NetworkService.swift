//
//  NetworkService.swift
//  PokemonSit
//
//  Created by Анна Шербицкая on 28.01.23.
//

import Foundation

protocol Networking {
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: Networking {
    
    private let dataCache = NSCache<NSString, NSData>()
    
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let cacheKey = urlString as NSString
        if let data = dataCache.object(forKey: cacheKey) {
            print("cached item")
            DispatchQueue.main.async {
                completion(data as Data, nil)
            }
            return
        }
        
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, for: cacheKey, completion: completion)
        task.resume()
    }
    
    func createDataTask(from request: URLRequest, for cacheKey: NSString, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("error is \(error?.localizedDescription)")
                return
            }
            let cacheValue = data as NSData
            self?.dataCache.setObject(cacheValue, forKey: cacheKey)
            print("downloaded item")
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    func checkDataInCache(for key: String) -> Data? {
        let cacheKey = key as NSString
        if let data = dataCache.object(forKey: cacheKey) {
            return data as Data
        } else {
            return nil
        }
    }
}
