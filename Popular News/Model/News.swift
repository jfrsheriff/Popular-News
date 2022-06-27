//
//  News.swift
//  Popular News
//
//  Created by Jaffer Sheriff U on 09/06/22.
//

import Foundation

struct News: Codable {
    let status : String
    let copyright : String
    let noOfArticles : Int
    let results : [Article]
    
    private enum CodingKeys: String, CodingKey {
        case status,copyright,noOfArticles = "num_results",results
    }
}

struct Article : Codable, Identifiable{
    var url : String
    let adx_keywords : String
    let subsection : String
    let column : String?
    let eta_id : Int
    
    let section : String
    let id : Int
    let asset_id : Int
    let nytdsection : String
    let byline : String
    let type : String
    let title : String
    let abstract : String
    let published_date : String
    let source : String
    let updated : String
    let des_facet : [String]
    let org_facet : [String]
    let per_facet : [String]
    let geo_facet : [String]
    let media : [Media]
    
    public func getArticleImageUrlString() -> String? {
        guard let media = self.media.first, let metaData = media.mediametadata.last else {
            return nil
        }
        return metaData.url.count > 0 ? metaData.url : nil
    }
}

struct Media : Codable {
    let type : String
    let subtype : String
    let caption : String
    let copyright : String
    let approved_for_syndication : Int
    let mediametadata : [MediaMetaData]
    
    private enum CodingKeys: String, CodingKey {
        case type,subtype,caption,copyright,approved_for_syndication,mediametadata = "media-metadata"
    }
}

struct MediaMetaData : Codable{
    let url : String
    let format : String
    let height : Int
    let width : Int
}

struct MockData {
    
    let news : News
    static let shared : MockData = MockData.init()
    
    private init () {
        guard let url = Bundle.main.url(forResource: "SampleResponse", withExtension: nil) else {
            fatalError()
        }
        
        do {
            let data = try Data.init(contentsOf: url, options: .alwaysMapped)
            
            let decoder = JSONDecoder.init()
            self.news = try decoder.decode(News.self, from: data)
            print(self.news)
        }catch{
            print(error)
            fatalError()
        }
    }
    
    
    public func getMockArticle() -> Article{
        self.news.results[0]
    }

}

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
