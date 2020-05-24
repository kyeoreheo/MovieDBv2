//
//  SummaryModel.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var summaryModel: SummaryModel
    @EnvironmentObject var detailModel: DetailModel
    @EnvironmentObject var commentModel: CommentModel
    @EnvironmentObject var currentMovie: CurrentMovie
    
    @State var section = 0
    @State var isLoading = true
    @State var showignDetail = false
    
    @State var popularPage = true
    @State var recommendedPage = false
    @State var latestPage = false

    init() {
        
    }
    
    var body: some View {
        NavigationView {
             TabView {
                SummaryView(viewModel: summaryModel)
                    .tabItem({Text("TableView").modifier(GeneralText(size:25))})
                    .tag("TableView")
                
                CollectionView(viewModel: summaryModel)
                    .tabItem({Text("CollectionView")
                    .modifier(GeneralText(size:25))})
                    .tag("CollectionView")
             }
             .padding(.top, -60)
             .accentColor(Color.black)
             .navigationBarTitle("MovieDB")
             .navigationBarItems(trailing:
                HStack{
                    HStack {
                        Button(action: {
                            self.summaryModel.fetchSummary(forType: 0)

                            withAnimation{
                                self.popularPage = true
                                self.recommendedPage = false
                                self.latestPage = false
                            }
                        }) {
                            Text("Popular")
                                .padding(5)
                                .modifier(GeneralText(color: self.popularPage ? .black : .white))
                                .background(self.popularPage ? Color.white : MyColor.darkGray)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            self.summaryModel.fetchSummary(forType: 1)

                            withAnimation{
                                self.popularPage = false
                                self.recommendedPage = true
                                self.latestPage = false
                            }
                        }) {
                            Text("Recommended")
                                .padding(5)
                                .modifier(GeneralText(color: self.recommendedPage ? .black : .white))
                                .background(self.recommendedPage ? Color.white : MyColor.darkGray)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            self.summaryModel.fetchSummary(forType: 2)

                            withAnimation{
                                self.popularPage = false
                                self.recommendedPage = false
                                self.latestPage = true
                            }
                        }) {
                            Text("Latest")
                                .padding(5)
                                .modifier(GeneralText(color: self.latestPage ? .black : .white))
                                .background(self.latestPage ? Color.white : MyColor.darkGray)
                                .cornerRadius(10)
                        }
                    }
                }
            )
        }
        .sheet(isPresented: self.$currentMovie.showingDetail ) {
            DetailView(summaryModel: self.summaryModel,
                       detailModel: self.detailModel,
                       commentModel: self.commentModel,
                       index: self.currentMovie.index)
                .environmentObject(self.currentMovie)
        }
        .onAppear(perform: {
            // as soon as this View on screen
            self.summaryModel.fetchSummary(forType: 0)
        })
    }
}
