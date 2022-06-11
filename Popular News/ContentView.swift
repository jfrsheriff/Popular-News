//
//  ContentView.swift
//  Popular News
//
//  Created by Jaffer Sheriff U on 09/06/22.
//

import SwiftUI

struct ContentView: View {
    
    enum Tab {
        case list
        case setting
    }
    
    @State private var selection: Tab = .list
        
    var body: some View {
        TabView{
            ArticleListView()
                .tabItem {
                    Label("News", systemImage: "newspaper.fill")
                }
                .tag(Tab.list)
            
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(Tab.setting)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
