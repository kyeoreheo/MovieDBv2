//
//  MovieCell.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI

struct SummaryCell: View {
    @EnvironmentObject var currentMovie: CurrentMovie
    let index: Int

    private let viewModel: SummaryCellVM
    
    init(viewModel: SummaryCellVM, index: Int) {
        self.viewModel = viewModel
        self.index = index
    }
    
    var body: some View {
        VStack (alignment: .center) {
            ZStack {
                MyColor.lightlightGray.edgesIgnoringSafeArea(.all) //set background
                
                HStack(alignment: .top, spacing: 20) {
                    UrlImageVeiw(urlString: self.viewModel.thumb)
                        .frame(width: 99, height: 141)
                        .cornerRadius(2)
                    
                    VStack(alignment: .leading) {
                        Text(self.viewModel.title)
                            .modifier(GeneralText(size:20))
                            .minimumScaleFactor(0.01)
                            .frame(width: 200, height: 40, alignment: .leading)

                        Text("Release: \(self.viewModel.releaseDate)")
                            .modifier(GeneralText())
                            .padding(.top)
                        
                        VStack(alignment: .trailing) {
                            Spacer()
                            HStack(spacing: 20) {
                                
                                RankIcon(self.viewModel.rank)
                                    .scaleEffect(1)
                                    .offset(y:-4)

                                StarIcon(self.viewModel.userRating)
                                    .scaleEffect(1)
                                    .offset(y:-4)
                                
                                Image(self.viewModel.grade)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                            }
                            .padding(.bottom,10)
                        }
                    }
                }
                .padding()
            }
        }
        .onTapGesture {
            self.currentMovie.movieId = self.viewModel.movieId
            self.currentMovie.showingDetail = true
            self.currentMovie.index = self.index
        }

        .frame(width: 380, height: 180)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10)
        .stroke(Color.gray, lineWidth: 6))
        .shadow(radius: 5)
        .padding()

    }
}


