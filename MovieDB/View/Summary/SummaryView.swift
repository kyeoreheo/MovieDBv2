//
//  MovieTableView.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI

struct SummaryView: View {
    @ObservedObject var viewModel: SummaryVM
    
    init(viewModel: SummaryVM) {
        self.viewModel = viewModel
    }
    var body: some View {
        ScrollView (showsIndicators: false){
            VStack {
                if viewModel.dataSource.count > 0 {
                    ForEach (0..<viewModel.dataSource.count) {
                        SummaryCell(viewModel: self.viewModel.dataSource[$0])
                    }
                } else {
                    Text("Loading...")
                    .frame(width: 500, height: 300)
                }
            }
        }
    }
}

