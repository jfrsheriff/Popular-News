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
            ProgressView()
                .progressViewStyle(.circular)
        }
    }
}


class ImageLoader : ObservableObject{
    
    @Published var image : Image? = nil
    private var imageRequest : ImageRequest?
    
    func loadImage(fromUrlStr urlStr: String){
        
        guard let imgUrl = URL(string: urlStr) else {
            return
        }
        
        if self.image == nil{
            let imageRequest = ImageRequest(url: imgUrl)
            self.imageRequest = imageRequest
            
            imageRequest.execute { [weak self] result in
                if case let .success(uiImage) = result {
                    self?.image = Image.init(uiImage: uiImage)
                }
            }
        }
    }
    
}
