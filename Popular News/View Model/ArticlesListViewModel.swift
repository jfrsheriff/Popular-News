//
//  ArticlesListViewModel.swift
//  Popular News
//
//  Created by Jaffer Sheriff U on 10/06/22.
//

import Foundation

final class ArticlesListViewModel : ObservableObject{
    
    @Published var articles : [Article] = []
    @Published var alertItem : AlertItem?
    @Published var errorOccured : Bool = false
    
    var selectedArticle : Article?
    
    private let userDefaultsHandler = UserDefaultHandler.shared
    private let networkManager = NetworkManager.shared
    
    private var currentNoOfDays = UserDefaultHandler.shared.getUserSelectedNoOfDays()
    private var currentPopularArticleType = UserDefaultHandler.shared.getUserSelectedArticleType()
    
    private var shouldFlushDataAndRefresh : Bool = true
    
    
    public func fetchPopularNewsOnPullToRefresh(completion : @escaping () -> Void ){
        shouldFlushDataAndRefresh = true
        self.getTopArticles(completion: completion)
    }
    
    public func fetchPopularNewsOnViewAppear(completion : @escaping () -> Void ){
        if isNewsConfigurationsChanged(){
            currentNoOfDays = userDefaultsHandler.getUserSelectedNoOfDays()
            currentPopularArticleType = userDefaultsHandler.getUserSelectedArticleType()
            
            shouldFlushDataAndRefresh = true
        }
        self.getTopArticles(completion: completion)
    }
    
    private func isNewsConfigurationsChanged() -> Bool {
        if currentNoOfDays != userDefaultsHandler.getUserSelectedNoOfDays() ||
            currentPopularArticleType != userDefaultsHandler.getUserSelectedArticleType(){
            return true
        }
        return false
    }
    
    //    Method Fetches Top Articles based on the user conguration or default configuration for atricle popularity type (Emailed, Shared, Viewed) and article period (1 day or 7 days or 30 days)
    
    private func getTopArticles(completion : @escaping () -> Void ){
        if !shouldFlushDataAndRefresh{
            completion()
            return
        }
        
        fetchTopArticlesFor(articleType: userDefaultsHandler.getUserSelectedArticleType(),
                            days: userDefaultsHandler.getUserSelectedNoOfDays()) { result in
            
            DispatchQueue.main.async {
                self.shouldFlushDataAndRefresh = false
                switch result{
                    case .success(let news) :
                        self.articles = news.results
                        
                    case .failure(let error) :
                        self.articles = []
                        self.errorOccured = true
                        
                        switch error{
                            case .invalidURL:
                                self.alertItem = AlertContext.invalidURL
                            case .unableToComplete:
                                self.alertItem = AlertContext.unableToComplete
                            case .invalidResponse:
                                self.alertItem = AlertContext.invalidResponse
                            case .invalidData:
                                self.alertItem = AlertContext.invalidData
                        }
                }
                completion()
            }
        }
    }
    
    // Helper method which uses URLManager and NetworkManager to fetch data and decode it in to Model Object
    
    private func fetchTopArticlesFor(articleType : PopularArticlesType,
                                     days : LastNoOfDays,
                                     completion: @escaping (Result<News,NewsError>) -> Void ) {
        
        let urlStr = URLManager.getUrlStringFor(articleType: articleType, days: days)
        networkManager.getDataFor(urlStr: urlStr) { result in
            switch result {
                    
                case .success(let data):
                    do{
                        let jsonDecoder = JSONDecoder.init()
                        let decodedNewsResponse = try jsonDecoder.decode(News.self, from: data)
                        completion(.success(decodedNewsResponse))
                    }catch{
                        completion(.failure(.invalidData))
                    }
                    
                    
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
