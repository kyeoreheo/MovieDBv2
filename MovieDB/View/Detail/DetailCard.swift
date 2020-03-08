//
//  DetailCardView.swift
//  MovieDB
//
//  Created by Kyo on 3/7/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI

struct DetailCard: View, Identifiable {
    var id = UUID()
    
    @ObservedObject var viewModel: DetailVM
    let thumb: String
    
    init(viewModle: DetailVM, supportModel: SummaryVM, index: Int) {
        self.viewModel = DetailVM(movieFetcher: MovieFetcher(), movieId: supportModel.movieId[index])
        self.thumb = supportModel.dataSource[index].thumb
    }
    
    var body: some View {
        ZStack {
            MyColor.lightlightGray.edgesIgnoringSafeArea(.all) //set background
            VStack {
                Text("\(self.viewModel.dataSource?.audience ?? "N/a")")
                    .frame(width:200, height: 20)
                UrlImageVeiw(urlString: self.thumb)
                .frame(width: 200, height: 300)
            }
        }
        .frame(width: 200, height: 300)
        //.padding()
    }
}
