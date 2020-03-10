//
//  MovieTableView.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
import SwiftUI

struct SummaryView: View {
    @ObservedObject var viewModel: SummaryModel
    
    var body: some View {

        GeometryReader { geo in
            ScrollView (showsIndicators: false){
                VStack {
                    if self.viewModel.dataSource.count > 0 {
                        ForEach (0..<self.viewModel.dataSource.count) {
                            SummaryCell(viewModel: self.viewModel.dataSource[$0], index: $0, cellWidth: (geo.size.width * 0.9))
                            .frame(height: 180)
                            .padding()
                        }
                    } else {
                        Text("Loading...")
                        .frame(width: 500, height: 300)
                    }
                }
            }
        }
    }
}

