//
//  UserDefaultHandler.swift
//  Popular News
//
//  Created by Jaffer Sheriff U on 10/06/22.
//

import Foundation

protocol StateSavingProtocol{
    func saveUserSelectedArticleType(_ articleType : PopularArticlesType)
    func saveUserSelectedNoOfDays(_ noOfDays : LastNoOfDays)
    func getUserSelectedArticleType() -> PopularArticlesType
    func getUserSelectedNoOfDays() -> LastNoOfDays
}


struct UserDefaultHandler : StateSavingProtocol {
    
    static public let shared : UserDefaultHandler = UserDefaultHandler.init()
    private let userDefault = UserDefaults.standard
    
    private init(){}
    
    public func saveUserSelectedArticleType(_ articleType : PopularArticlesType){
        userDefault.set(articleType.rawValue, forKey: UserDefaultKeys.articleType)
    }
    
    public func saveUserSelectedNoOfDays(_ noOfDays : LastNoOfDays){
        userDefault.set(noOfDays.rawValue, forKey: UserDefaultKeys.noOfDays)
    }
    
    public func getUserSelectedArticleType() -> PopularArticlesType {
        if let rawValue = userDefault.string(forKey: UserDefaultKeys.articleType),
           let savedType = PopularArticlesType.init(rawValue: rawValue) {
            return savedType
        }
        return .shared
    }
    
    public func getUserSelectedNoOfDays() -> LastNoOfDays {
        let rawIntValue = userDefault.integer(forKey: UserDefaultKeys.noOfDays)
        if let savedType = LastNoOfDays.init(rawValue: rawIntValue) {
            return savedType
        }
        return .today
    }
    
}


private struct UserDefaultKeys{
    static let articleType : String = "articleType"
    static let noOfDays : String = "noOfDays"
}
