//
//  CollectionViewItem.swift
//  MovieDB
//
//  Created by Kyo on 3/8/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
import SwiftUI

struct CollectionViewItem: View {
    @ObservedObject var viewModel: SummaryVM
    
    @EnvironmentObject var currentMovie: CurrentMovie
    
    let index: Int
    
    init(viewModel: SummaryVM, index: Int) {
        self.viewModel = viewModel
        self.index = index
    }
    
    var body: some View {
        VStack {
            UrlImageVeiw(urlString: self.viewModel.dataSource[index].thumb)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(gradeToColor(grade: self.viewModel.dataSource[index].grade), lineWidth: 6))
                .shadow(radius: 5)
                .frame(width: 180, height: 280)
                .onTapGesture {
                    self.currentMovie.movieId = self.viewModel.dataSource[self.index].movieId
                    self.currentMovie.showingDetail = true
                    self.currentMovie.index = self.index
                }
        }
        .frame(width: 200, height: 300)

    }
    
    func gradeToColor(grade: String) -> Color {
        switch grade {
        case "12":
            return MyColor.blue
        case "15":
            return MyColor.Yellow
        case "19":
            return MyColor.red
        default:
            return MyColor.green
        }
    }
}

