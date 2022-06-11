//
//  ProfileView.swift
//  Popular News
//
//  Created by Jaffer Sheriff U on 10/06/22.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack{
            ProfileImageWithNameView(imageName: "Profile",
                                     profileName: ProfileDetailsConstants.name)
            Spacer()
                .frame( height: 50)
            
            VStack(alignment: .leading, spacing: 15){
                HStack{
                    Image(systemName: "envelope")
                    Text(verbatim:ProfileDetailsConstants.emailId)
                }
                HStack{
                    Image(systemName: "phone")
                    Text(verbatim:ProfileDetailsConstants.mobileNumber)
                }
            }
            
            Spacer()
                .frame( height: 50)
            
            HStack(spacing: 40){
                
                ExtractedView()
                ExternalProfileLinkView(imageName: "GitHub",
                                        profileUrlStr: ProfileURLConstants.gitHub)
                ExternalProfileLinkView(imageName: "LeetCode",
                                        profileUrlStr: ProfileURLConstants.leetCode)
                ExternalProfileLinkView(imageName: "Instagram",
                                        profileUrlStr: ProfileURLConstants.instagram)
                
                
            }
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


struct ProfileImageWithNameView : View{
    
    var imageName : String
    var profileName : String
    
    var body: some View{
        VStack(spacing : 25){
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 2)
                    
                }
                .shadow(radius: 5)
            
            Text(profileName)
                .font(.headline)
                .fontWeight(.heavy)
        }
    }
}


struct ProfileImageWithNameView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageWithNameView(imageName: "Profile",
                                 profileName: "Jaffer Sheriff")
    }
}



struct ExtractedView: View {
    var body: some View {
        ExternalProfileLinkView(imageName: "LinkedIn",
                                profileUrlStr: ProfileURLConstants.linkedIn)
    }
}
