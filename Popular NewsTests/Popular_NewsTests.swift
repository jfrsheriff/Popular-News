//
//  Popular_NewsTests.swift
//  Popular NewsTests
//
//  Created by Jaffer Sheriff U on 09/06/22.
//

import XCTest
@testable import Popular_News

class Popular_NewsTests: XCTestCase {
    
    let userDefaultHandler = UserDefaultHandler.shared
    
    
    func testUserDefaultsHandlerForArticleType() throws {
        let newArticleType = PopularArticlesType.emailed
        userDefaultHandler.saveUserSelectedArticleType(newArticleType)
        XCTAssert(newArticleType == userDefaultHandler.getUserSelectedArticleType(),"Error in retriving Saved Data from User Defaults Handler")
    }
    
    func testUserDefaultsHandlerForNoOfDays() throws {
        let newNoOfDays = LastNoOfDays.month
        userDefaultHandler.saveUserSelectedNoOfDays(newNoOfDays)
        XCTAssert(newNoOfDays == userDefaultHandler.getUserSelectedNoOfDays(),"Error in retriving Saved Data from User Defaults Handler")
    }
    
    func testURLManagerForEmailedArticles() throws {
        let urlStr1  = URLManager.getUrlStringFor(articleType: .emailed, days: .today)
        let urlStr2 = URLManager.getUrlStringFor(articleType: .emailed, days: .week)
        let urlStr3 = URLManager.getUrlStringFor(articleType: .emailed, days: .month)
        
        let secretKeyParam = KeyConstants.apiKey + "=" + KeyConstants.secretKeyValue
        let t1 = "https://api.nytimes.com/svc/mostpopular/v2/emailed/1.json?" + secretKeyParam
        let t2 = "https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json?" + secretKeyParam
        let t3 = "https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json?" + secretKeyParam
        
        XCTAssert(urlStr1 == t1, "Error in Generatinng URL For Today, Emailed articles")
        XCTAssert(urlStr2 == t2, "Error in Generatinng URL For This Week,  Emailed articles")
        XCTAssert(urlStr3 == t3, "Error in Generatinng URL For This Month,  Emailed articles")
        
    }
    
    func testURLManagerForSharedArticles() throws {
        let urlStr1  = URLManager.getUrlStringFor(articleType: .shared, days: .today)
        let urlStr2 = URLManager.getUrlStringFor(articleType: .shared, days: .week)
        let urlStr3 = URLManager.getUrlStringFor(articleType: .shared, days: .month)
        
        let secretKeyParam = KeyConstants.apiKey + "=" + KeyConstants.secretKeyValue
        let t1 = "https://api.nytimes.com/svc/mostpopular/v2/shared/1.json?" + secretKeyParam
        let t2 = "https://api.nytimes.com/svc/mostpopular/v2/shared/7.json?" + secretKeyParam
        let t3 = "https://api.nytimes.com/svc/mostpopular/v2/shared/30.json?" + secretKeyParam
        
        XCTAssert(urlStr1 == t1, "Error in Generatinng URL For Today, Shared articles")
        XCTAssert(urlStr2 == t2, "Error in Generatinng URL For This Week,  Shared articles")
        XCTAssert(urlStr3 == t3, "Error in Generatinng URL For This Month,  Shared articles")
    }
    
    func testURLManagerForViewedArticles() throws {
        let urlStr1  = URLManager.getUrlStringFor(articleType: .viewed, days: .today)
        let urlStr2 = URLManager.getUrlStringFor(articleType: .viewed, days: .week)
        let urlStr3 = URLManager.getUrlStringFor(articleType: .viewed, days: .month)
        
        
        let secretKeyParam = KeyConstants.apiKey + "=" + KeyConstants.secretKeyValue
        let t1 = "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?" + secretKeyParam
        let t2 = "https://api.nytimes.com/svc/mostpopular/v2/viewed/7.json?" + secretKeyParam
        let t3 = "https://api.nytimes.com/svc/mostpopular/v2/viewed/30.json?" + secretKeyParam
        
        XCTAssert(urlStr1 == t1, "Error in Generatinng URL For Today, Viewed articles")
        XCTAssert(urlStr2 == t2, "Error in Generatinng URL For This Week,  Viewed articles")
        XCTAssert(urlStr3 == t3, "Error in Generatinng URL For This Month,  Viewed articles")
    }
    
}
