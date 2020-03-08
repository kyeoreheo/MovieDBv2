//
//  UrlImageVeiw.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI

struct UrlImageVeiw: View {
    @ObservedObject var urlImageModel: UrlImageModel
    static var defaultImage = UIImage(named: "logo")
    
    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? UrlImageVeiw.defaultImage!).resizable()
    }
}

