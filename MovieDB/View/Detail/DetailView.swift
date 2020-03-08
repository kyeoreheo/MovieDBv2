//
//  MovieCollectionView.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel: DetailVM
    @EnvironmentObject var movieModel: SummaryVM
    //let movieId: [String]
    
    init(viewModel: DetailVM) {

    }
    
    var body: some View {
     ScrollView (showsIndicators: false){
           VStack {
            
           
//            if viewModel.dataSource.count > 0 {
                ForEach (0..<movieModel.movieId.count) {
                    DetailCard(viewModle: self.viewModel, movieId: self.movieModel.movieId[$0])
                    //DetailCard(viewModel: self.viewModel.dataSource[$0])
                    }
//                } else {
//                    Text("Hi")
//                    .frame(width: 500, height: 300)
//                }
           }.onAppear(perform: {
                //self.viewModel.fetchDetail()
           })
       }

    }
}

