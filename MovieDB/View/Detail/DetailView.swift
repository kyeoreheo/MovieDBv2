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
    @EnvironmentObject var viewModel2: SummaryVM
    //let movieId: [String]
    
    init(viewModel: DetailVM) {

    }
    
    var body: some View {
     ScrollView (showsIndicators: false){
           VStack {
            if viewModel.dataSource.count > 0 {
                ForEach (viewModel.dataSource) {_ in
                    Text("DetailVM\(self.viewModel.dataSource.count)")
                    //DetailCard(viewModel: self.viewModel.dataSource[$0])
                    }
                } else {
                    Text("Hi")
                    .frame(width: 500, height: 300)
                }
           }.onAppear(perform: {
                self.viewModel.fetchDetail()
           })
       }

    }
}

