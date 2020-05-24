//
//  ImageLoader.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    var downloadedImage: UIImage?
    let didChange = PassthroughSubject<ImageLoader?, Never>()
    
    func fetchImage(url: String) {
        guard let imageURL = URL(string: url)
        else { fatalError("ImageURL is not correct") }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, error == nil
            else {
                DispatchQueue.main.async { self.didChange.send(nil) }
                return
            }
            self.downloadedImage = UIImage(data: data)
            DispatchQueue.main.async {
                self.didChange.send(self)
            }
        }.resume()
    }
    
    
//    @Published var downloadImage: UIImage?
//
//
//    func fetchImage(url: String) {
//        guard let imageURL = URL(string: url)
//        else { fatalError("The url string is invalid") }
//        URLSession.shared.dataTask(with: imageURL) { data, response, error in
//            guard let data = data, error == nil
//            else { fatalError("error reading the image") }
//
//            DispatchQueue.main.async {
//                self.downloadImage = UIImage(data: data)
//            }
//
//        }
//    }
    
}
