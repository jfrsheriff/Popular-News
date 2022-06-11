//
//  ArticleDetailView.swift
//  Popular News
//
//  Created by Jaffer Sheriff U on 10/06/22.
//

import SwiftUI
import SafariServices

struct ArticleDetailView: UIViewControllerRepresentable {
    typealias UIViewControllerType = SFSafariViewController
    
    let url : URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let sfViewController = SFSafariViewController.init(url: url)
        return sfViewController
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(url: URL(string: "https://www.google.co.in/")!)
    }
}
