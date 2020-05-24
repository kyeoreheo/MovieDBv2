//
//  CollectionView.swift
//  MovieDB
//
//  Created by Kyo on 3/8/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var viewModel: SummaryModel
    
    @State var count: Int = 0
    
    init(viewModel: SummaryModel) {
    }
    
    var body: some View {
        ScrollView (.vertical, showsIndicators: false){
            VStack  {
                ForEach(0..<(viewModel.movieId.count/2)) { vIndex in
                    HStack{
                        ForEach (vIndex..<vIndex + 2) { hIndex in
                            CollectionViewItem(viewModel: self.viewModel, index: hIndex + vIndex)
                        }
                    }
                }
            }
        }
    }
}


