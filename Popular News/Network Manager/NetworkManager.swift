//
//  NetworkManager.swift
//  Popular News
//
//  Created by Jaffer Sheriff U on 09/06/22.
//

import Foundation
import UIKit

struct NetworkManager{
    
    static let shared : NetworkManager = NetworkManager.init()
    private let cache = NSCache<NSString, UIImage>()
    
    
    private init(){
        
    }
    
    public func getDataFor(urlStr : String , completion: @escaping (Result<Data,NewsError>) -> Void ) {
        
        guard let url = URL(string: urlStr) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response , error in
            
            if let _ =  error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            completion(.success(data))
        }
        
        task.resume()
    }
    
    
    public func loadImageFrom(urlStr : String , completion: @escaping (UIImage?) -> Void ){
        
        let cacheKey = NSString(string: urlStr)
        
        if let image = cache.object(forKey: cacheKey){
            completion(image)
            return
        }
        
        guard let url = URL(string: urlStr) else {
            completion(nil)
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, let image = UIImage.init(data: data) else {
                completion(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        
        task.resume()
        
    }
    
    
    
}
