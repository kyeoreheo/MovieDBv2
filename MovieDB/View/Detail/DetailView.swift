//
//  MovieCollectionView.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI
import QGrid

struct DetailView: View {
    @EnvironmentObject var viewModel: DetailVM
    @EnvironmentObject var supportModel: SummaryVM
    @State var cards: [DetailCard] = []
    @State var count: Int = 0
    
    //let movieId: [String]
    
    init(viewModel: DetailVM) {

    }
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false){
            VStack  {
                ForEach(0..<(supportModel.movieId.count/2)) { vIndex in
                    HStack{
                        ForEach (vIndex..<vIndex + 2) { hIndex in
                            DetailCard(viewModle: self.viewModel, supportModel: self.supportModel, index: hIndex + vIndex)
                        }
                    }
                }
            }.padding()
        
        }
    }
}

