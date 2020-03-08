//
//  DetailCardView.swift
//  MovieDB
//
//  Created by Kyo on 3/7/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI

struct DetailCard: View {
    //@EnvironmentObject var viewModel: DetailVM
    @ObservedObject var viewModel: DetailVM

    
    init(viewModle: DetailVM, movieId: String) {
//        print(movieId)
//        print(viewModel.movieId.count)
        self.viewModel = viewModle
        self.viewModel.fetchDetail(forId: movieId)
    //viewModel.fetchDetail(forId: movieId)
    }
    
    var body: some View {
        VStack {
            if self.viewModel.dataSource != nil {
                Text("\(self.viewModel.dataSource?.audience ?? "N/a")")
            }
            else {
                Text("Loading")
            }
        }
    }
}
