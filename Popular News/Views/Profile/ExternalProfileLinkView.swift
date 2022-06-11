//
//  ExternalProfileLinkView.swift
//  Popular News
//
//  Created by Jaffer Sheriff U on 10/06/22.
//

import SwiftUI

struct ExternalProfileLinkView: View {
    let imageName : String
    let profileUrlStr : String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View{
        Image(imageName)
            .resizable()
            .renderingMode(.template)
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .frame(width: 40, height: 40)
            .onTapGesture {
                openExternalUrl(urlString: profileUrlStr)
            }
    }
    
    func openExternalUrl(urlString : String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        UIApplication.shared.open(url)
    }
}

struct ExternalProfileLinkView_Previews: PreviewProvider {
    static var previews: some View {
        ExternalProfileLinkView(imageName: "LinkedIn", profileUrlStr: "https://www.linkedin.com/in/jaffer-sheriff-07354b68/")
    }
}

