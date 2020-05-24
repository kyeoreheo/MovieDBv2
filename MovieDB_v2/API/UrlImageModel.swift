//
//  MovieError.swift
//  MovieDB
//
//  Copyright © 2020 Kyeore Heo. All rights reserved.
//

import UIKit

class UrlImageModel: ObservableObject {
    @Published var image = UIImage(named: "placeHolder")
    @Published var hasImage = false
    
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
                self.hasImage = true
            }
        }.resume()
    }
}
