//
//  ErrorView.swift
//  Popular News
//
//  Created by Jaffer Sheriff U on 11/06/22.
//

import SwiftUI

struct ErrorView: View {
    
    let title : Text
    let message : Text
    
    @Binding var isErrorOccured : Bool
    
    var body: some View {
        ZStack{
            VStack{
                Image(systemName: "xmark.octagon.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.red)
                
                title
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .font(.title2)
                
                Spacer()
                    .frame(height:10)
                
                message
                    .fontWeight(.regular)
                    .foregroundColor(.primary)
                    .font(.title3)
                
                Spacer()
                    .frame(height:50)
                
                Button {
                    isErrorOccured = false
                } label: {
                    Label(StringConstants.reloadText, systemImage: "arrow.clockwise.circle.fill")
                        .frame(width: 220, height: 80, alignment: .center)
                        .font(.title)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(10)
                }
            }
            .padding(.all, 20)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(title: AlertContext.fetchingError.title,
                  message: AlertContext.fetchingError.message,
                  isErrorOccured: .constant(true))
    }
}
