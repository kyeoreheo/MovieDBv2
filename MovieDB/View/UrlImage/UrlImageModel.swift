//
//  UrlImageModel.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
import Foundation
import SwiftUI

class UrlImageModel: ObservableObject {
    @Published var image: UIImage?
    
    init(urlString: String?) {
        guard let url = urlString
        else { return }
        fetchImage(urlString: url)
    }
    
    func fetchImage(urlString: String) {
        guard let url = URL(string: urlString)
        else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil
            else { fatalError( "URL is not correct" ) }

            DispatchQueue.main.async {
                guard let loadedImage = UIImage(data: data)
                else { fatalError( "Image is not correct" ) }
                self.image = loadedImage
            }
        }.resume()
    }
}
