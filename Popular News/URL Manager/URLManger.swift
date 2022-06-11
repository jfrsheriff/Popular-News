//
//  URLManger.swift
//  Popular News
//
//  Created by Jaffer Sheriff U on 09/06/22.
//

import Foundation

enum PopularArticlesType : String, CaseIterable, Identifiable{
    var id: RawValue { rawValue }
    
    case emailed = "emailed"
    case shared = "shared"
    case viewed = "viewed"
    
    var getCapitalizedRawValue : String {
        self.rawValue.capitalized
    }
}

enum LastNoOfDays : Int, CaseIterable, Identifiable{
    var id: RawValue { rawValue }
    
    case today = 1
    case week = 7
    case month = 30
    
    var getStringValue : String {
        switch self {
            case .today:
                return "Today"
            case .week:
                return "This Week"
            case .month:
                return "This Month"
        }
    }
}

struct KeyConstants {
    static let apiKey = "api-key"
    static let secretKeyValue = "dsVqfMtPGlEXJkaQB7HYX2cqWdJptHQo"
}


struct URLManager {
    static let baseUrl = "https://api.nytimes.com/svc/mostpopular/v2/"
    
    static func getUrlStringFor(articleType : PopularArticlesType, days : LastNoOfDays) -> String {
        
        let urlStr = URLManager.baseUrl.appending(articleType.rawValue) + "/\(days.rawValue).json" + "?" + KeyConstants.apiKey + "=" + KeyConstants.secretKeyValue
        
        return urlStr
    }
}

