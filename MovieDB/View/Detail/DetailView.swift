//
//  MovieCollectionView.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var summaryModel: SummaryVM
    @ObservedObject var detailModel: DetailVM
    @ObservedObject var commentModel: CommentVM
    
    @State var onScreen = false
    
    let index: Int
    init(summaryModel: SummaryVM, detailModel: DetailVM, commentModel: CommentVM, index: Int) {
        self.index = index
        self.summaryModel = summaryModel
        self.detailModel = detailModel
        self.commentModel = commentModel
        
        self.detailModel = DetailVM(movieFetcher: MovieFetcher(), movieId: self.summaryModel.movieId[index])
        //self.viewModel = DetailVM(movieFetcher: MovieFetcher(), movieId: supportModel.movieId[index])

    }
    
    var body: some View {
//        GeometryReader { geo in

            ZStack {
                UrlImageVeiw(urlString: self.summaryModel.dataSource[self.index].thumb)
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: self.onScreen ? 10 : 0)
                    .offset(y:-150)
                    .animation(.interpolatingSpring(mass: 1, stiffness: 1, damping: 5.0, initialVelocity: 1))
                //ScrollView (showsIndicators: false){
                DetailCardView(userRating: self.summaryModel.dataSource[self.index].userRating,
                            director: self.detailModel.dataSource?.director ?? "loading",
                            genre: self.detailModel.dataSource?.genre ?? "loading",
                            cast: self.detailModel.dataSource?.cast ?? "loading",
                            synopsis: self.detailModel.dataSource?.synopsis ?? "loading")

                    

            }
            .onAppear(perform: { self.onScreen.toggle()})
        
    }
}

