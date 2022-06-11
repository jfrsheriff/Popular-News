//
//  ArticleCell.swift
//  Popular News
//
//  Created by Jaffer Sheriff U on 10/06/22.
//

import SwiftUI

struct ArticleCell: View {
    
    var article : Article
    
    var imageExists : Bool {
        article.getArticleImageUrlString() != nil
    }
    
    var body: some View {
        VStack(alignment:.leading, spacing:5){
            Text(article.title)
                .foregroundColor(.primary)
                .fontWeight(.semibold)
                .fixedSize(horizontal: false, vertical: true)
                .font(.title2)
            
            HStack(spacing:5){
                VStack(alignment: .leading){
                    
                    Text(article.abstract)
                        .fontWeight(.regular)
                        .foregroundColor(.primary)
                        .padding(.all, 0)
                        .font(.body)
                    
                    Spacer()
                    HStack{
                        Text(article.published_date)
                            .fontWeight(.light)
                            .foregroundColor(.secondary)
                            .padding(.all, 0)
                            .font(.caption2)
                        
                        Spacer()
                        Text(article.byline)
                            .fontWeight(.light)
                            .foregroundColor(.secondary)
                            .padding(.all, 0)
                            .font(.caption2)
                    }
                }
                .frame(maxHeight:100)
                
                if let imageUrl = article.getArticleImageUrlString()  {
                    Spacer()
                    NewsRemoteImage(urlStr: imageUrl)
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(5)
                }
            }
        }
        .padding(EdgeInsets.init(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
}


