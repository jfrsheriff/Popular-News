//
//  ArticleListView.swift
//  Popular News
//
//  Created by Jaffer Sheriff U on 09/06/22.
//

import SwiftUI
import SafariServices

struct ArticleListView: View {
    
    @StateObject private var viewModel = ArticlesListViewModel.init()
    @State private var showSafariView : Bool = false
    @State private var isLoading : Bool = false
    
    var body: some View {
        
        ZStack{
            if viewModel.errorOccured{
                ErrorView(title: AlertContext.fetchingError.title,
                          message: AlertContext.fetchingError.message,
                          isErrorOccured: $viewModel.errorOccured)
            }else {
                NavigationView{
                    
                    List(viewModel.articles, id: \.id){ article in
                        ArticleCell.init(article: article)
                        
                            .onTapGesture {
                                showSafariView = true
                                viewModel.selectedArticle = article
                            }
                        
                            .sheet(isPresented: $showSafariView,
                                   content: {
                                
                                if let urlStr = viewModel.selectedArticle?.url,
                                   let url = URL(string: urlStr){
                                    ArticleDetailView.init(url: url)
                                }
                            })
                            .navigationTitle(StringConstants.articleListViewNavigationTitle)
                        
                    }
                    .refreshable {
                        fetchPopularNewsOnPullToRefresh()
                    }
                }
                
                if isLoading {
                    LoadingView()
                }
            }
            
        }
        
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
        
        .onAppear(){
            fetchPopularNewsOnViewAppear()
        }
        
        //  Handles refreshing on error cases
        .onChange(of: viewModel.errorOccured) { newValue in
            if viewModel.errorOccured == false{
                fetchPopularNewsAfterErrorOccured()
            }
        }
    }
    
    // Handles Pull to refresh
    func fetchPopularNewsOnPullToRefresh(){
        viewModel.fetchPopularNewsOnPullToRefresh {
            
        }
    }
    
    // Handles Refresh during view appearance
    
    func fetchPopularNewsOnViewAppear(){
        isLoading = true
        viewModel.fetchPopularNewsOnViewAppear {
            isLoading = false
        }
    }
    
    // Handles Refresh during Error Case
    
    func fetchPopularNewsAfterErrorOccured(){
        isLoading = true
        viewModel.fetchPopularNewsOnPullToRefresh {
            isLoading = false
        }
    }
    
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView()
    }
}
