//
//  NetworkManager.swift
//  Popular News
//
//  Created by Jaffer Sheriff U on 09/06/22.
//

import Foundation

struct NetworkManager{
    
    static let shared : NetworkManager = NetworkManager.init()
    
    private init(){
        
    }

    public func getDataFor(urlStr : String , completion: @escaping (Result<Data,Error>) -> Void ) {
        
        guard let url = URL(string: urlStr) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            
        }
    }
    
}
