//
//  ArticlesListViewModel.swift
//  Popular News
//
//  Created by Jaffer Sheriff U on 10/06/22.
//

import Foundation

protocol ArticlesListViewModelProtocol {
    var articles : [Article] { get set }
    var alertItem : AlertItem? { get set }
    var errorOccured : Bool { get set }
    var selectedArticle : Article?  { get set }
    var userPreferenceSaver : StateSavingProtocol { get }
}


final class ArticlesListViewModel : ObservableObject, ArticlesListViewModelProtocol {
    
    @Published var articles : [Article] = []
    @Published var alertItem : AlertItem?
    @Published var errorOccured : Bool = false
    
    var selectedArticle : Article?
    
    var userPreferenceSaver : StateSavingProtocol
    
    private var currentNoOfDays : LastNoOfDays
    private var currentPopularArticleType : PopularArticlesType
    
    private var shouldFlushDataAndRefresh : Bool = true
    
    private var request : APIRequest<NewsResource>?
    
    public func fetchPopularNewsOnPullToRefresh(completion : @escaping () -> Void ){
        shouldFlushDataAndRefresh = true
        self.getTopArticles(completion: completion)
    }
    
    init(userPreferenceSaver : StateSavingProtocol) {
        self.userPreferenceSaver = userPreferenceSaver
        self.currentNoOfDays = self.userPreferenceSaver.getUserSelectedNoOfDays()
        self.currentPopularArticleType = self.userPreferenceSaver.getUserSelectedArticleType()
    }
    
    public func fetchPopularNewsOnViewAppear(completion : @escaping () -> Void ){
        
        if isNewsConfigurationsChanged(){
            currentNoOfDays = userPreferenceSaver.getUserSelectedNoOfDays()
            currentPopularArticleType = userPreferenceSaver.getUserSelectedArticleType()
            
            shouldFlushDataAndRefresh = true
        }
        self.getTopArticles(completion: completion)
    }
    
    private func isNewsConfigurationsChanged() -> Bool {
        if currentNoOfDays != userPreferenceSaver.getUserSelectedNoOfDays() ||
            currentPopularArticleType != userPreferenceSaver.getUserSelectedArticleType(){
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
        
        let resource = NewsResource(articleType: userPreferenceSaver.getUserSelectedArticleType(),
                                    days: userPreferenceSaver.getUserSelectedNoOfDays())
        let request = APIRequest(resource: resource)
        self.request = request
        
        request.execute { [weak self] result in
            
            guard let self = self else {
                completion()
                return
            }
            
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
                        case .invalidDecoding:
                            self.alertItem = AlertContext.invalidDecoding
                        case .unKnown:
                            self.alertItem = AlertContext.unKnown
                    }
            }
            completion()
        }
    }
    
}
