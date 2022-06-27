//
//  NetworkRequest.swift
//  Popular News
//
//  Created by Jaffer Sheriff U on 26/06/22.
//


import Foundation
import UIKit

// MARK: - NetworkRequest

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute(withCompletion completion: @escaping (Result<ModelType,APIError>) -> Void)
}

extension NetworkRequest {
    fileprivate func load(_ url: URL, withCompletion completion: @escaping (Result<ModelType,APIError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { [weak self]  (data, response , error) -> Void in
            
            guard let self = self else {
                DispatchQueue.main.async {
                    completion(.failure(.unKnown))
                }
                return
            }
            
            if let _ =  error {
                DispatchQueue.main.async {
                    completion(.failure(.unableToComplete))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidData))
                }
                return
            }
            
            guard let value = self.decode(data) else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidDecoding))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(value))
            }
        }
        task.resume()
    }
}


class ImageRequest {
    typealias ModelType = UIImage
        
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
}

extension ImageRequest : NetworkRequest{
    
    func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    
    func execute(withCompletion completion: @escaping (Result<UIImage, APIError>) -> Void) {
        load(url, withCompletion: completion)
    }
    
}

// MARK: - APIRequest
class APIRequest<Resource: APIResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    func execute(withCompletion completion: @escaping (Result<Resource.ModelType, APIError>) -> Void) {
        load(resource.url, withCompletion: completion)
    }
        
    func decode(_ data: Data) -> Resource.ModelType? {
        let decoder = JSONDecoder()
        let decodedVal = try? decoder.decode(Resource.ModelType.self, from: data)
        return decodedVal
    }
    
}

// MARK: - APIResource
protocol APIResource {
    associatedtype ModelType: Decodable
    var methodPath: String { get }
    var queryItems: [URLQueryItem]? { get }
}

extension APIResource {
    var url: URL {
        var components = URLComponents(string: "https://api.nytimes.com")!
        components.path = methodPath
        
        let defaultQueryItem = URLQueryItem(name: KeyConstants.apiKey , value: KeyConstants.secretKeyValue )
        var queryItems = self.queryItems ?? []
        
        queryItems.append(defaultQueryItem)
        components.queryItems = queryItems
        
        return components.url!
    }
}

// MARK: - QuestionsResource
struct NewsResource: APIResource {
    
    typealias ModelType = News
    
    let articleType : PopularArticlesType
    let days : LastNoOfDays
    
    var queryItems: [URLQueryItem]?
    
    var methodPath: String {
        return "/svc/mostpopular/v2/\(articleType.rawValue)/\(days.rawValue).json"
    }
}


// MARK: - Wrapper
struct Wrapper<T: Decodable>: Decodable {
    let items: [T]
}
