//
//  SettingsView.swift
//  Popular News
//
//  Created by Jaffer Sheriff U on 09/06/22.
//

import SwiftUI

struct SettingsView: View {
    
    @State var articleType : PopularArticlesType = UserDefaultHandler.shared.getUserSelectedArticleType()
    
    @State var noOfDays : LastNoOfDays = UserDefaultHandler.shared.getUserSelectedNoOfDays()
    
    var body: some View {
        VStack {
            NavigationView{
                List{
                    Picker(StringConstants.articleTypeText , selection: $articleType) {
                        ForEach(PopularArticlesType.allCases , id: \.self) {
                            Text($0.getCapitalizedRawValue)
                        }
                    }
                    .pickerStyle(.inline)
                    .onChange(of: articleType) { newValue in
                        UserDefaultHandler.shared.saveUserSelectedArticleType(articleType)
                    }
                    
                    Picker(StringConstants.articlePeriodText, selection: $noOfDays) {
                        ForEach(LastNoOfDays.allCases , id: \.self) {
                            Text($0.getStringValue)
                        }
                    }
                    .onChange(of: noOfDays) { newValue in
                        
                        UserDefaultHandler.shared.saveUserSelectedNoOfDays(noOfDays)
                    }
                    .pickerStyle(.inline)
                    
                    
                    NavigationLink(StringConstants.settingsAboutLinkTitle) {
                        ProfileView()
                    }
                    
                    
                }
                
                .navigationTitle(StringConstants.settingsViewNavigationTitle)
            }
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


