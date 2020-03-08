//
//  DetailCardView.swift
//  MovieDB
//
//  Created by Kyo on 3/7/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI

struct DetailCard: View {
    @ObservedObject var viewModel: DetailVM
    @ObservedObject var supportModel: SummaryVM
    let index: Int
    
    init(viewModle: DetailVM, supportModel: SummaryVM, index: Int) {
        self.viewModel = DetailVM(movieFetcher: MovieFetcher(), movieId: supportModel.movieId[index])
        self.supportModel = supportModel
        self.index = index
    }
    
    var body: some View {
        VStack {
            Text("HI")
        }
    }
}


