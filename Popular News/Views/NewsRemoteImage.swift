//
//  NewsRemoteImage.swift
//  Popular News
//
//  Created by Jaffer Sheriff U on 10/06/22.
//

import SwiftUI

struct NewsRemoteImage: View {
    
    var urlStr : String
    @StateObject var imgLoader : ImageLoader = ImageLoader.init()
    
    var body: some View {
        RemoteImage(image: imgLoader.image)
            .onAppear(){
                imgLoader.loadImage(fromUrlStr: urlStr)
            }
    }
}


private struct RemoteImage : View {
    
    var image : Image?
    var body: some View {
        if let image = image{
            image.resizable()
        }else{
            Image.init(systemName: "newspaper.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40, alignment: .center)
        }
    }
}


class ImageLoader : ObservableObject{
    
    @Published var image : Image? = nil
    
    func loadImage(fromUrlStr urlStr: String){
        NetworkManager.shared.loadImageFrom(urlStr: urlStr) { uiImage in
            guard let uiImage = uiImage else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = Image.init(uiImage: uiImage)
            }
        }
    }
    
}
