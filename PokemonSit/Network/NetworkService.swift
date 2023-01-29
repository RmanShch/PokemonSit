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
    
    private let imageDataCache = NSCache<NSString, NSData>()
    
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let cacheKey = urlString as NSString
        if let data = imageDataCache.object(forKey: cacheKey) {
            print("cache item")
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
                return
            }
            let cacheValue = data as NSData
            self?.imageDataCache.setObject(cacheValue, forKey: cacheKey)
            print("downloaded item")
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
