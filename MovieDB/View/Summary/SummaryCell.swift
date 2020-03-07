//
//  MovieCell.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI

struct SummaryCell: View {
    private let viewModel: SummaryCellVM
    
    init(viewModel: SummaryCellVM) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack (alignment: .center) {
            ZStack {
                MyColor.lightlightGray.edgesIgnoringSafeArea(.all) //set background

                
                HStack(alignment: .top, spacing: 20) {
                    UrlImageVeiw(urlString: self.viewModel.thumb)
                    .frame(width: 99, height: 141)
                    
                    VStack(alignment: .leading) {
                        
                        HStack {
                            Text(self.viewModel.title)
                            .modifier(GeneralText(size:18))
                            .minimumScaleFactor(0.01)
                            .frame(width: 200, height: 20, alignment: .leading)
                        }
                        
                        HStack {
                            Image(self.viewModel.grade)
                            .resizable()
                            .frame(width: 30, height: 30)
                            
                            StarIcon(self.viewModel.userRating)
                            .scaleEffect(0.7)
                            .offset(y:-4)
                            
                        }
                        
                        Text("Release: \(self.viewModel.releaseDate)")
                        .modifier(GeneralText())
                    }
                }
                .padding()
            }
        }
    }
}


