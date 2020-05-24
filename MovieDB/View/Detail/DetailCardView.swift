//
//  DetailFrame.swift
//  MovieDB
//
//  Created by Kyo on 3/8/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
import SwiftUI

struct DetailCardView: View {
    private let viewModel: DetailCardVM?

    @ObservedObject var supportModel: CommentModel
    
    @State var summaryPage = true
    @State var commentPage = false
    
    init(viewModel: DetailCardVM?, supportModel: CommentModel) {
        self.viewModel = viewModel
        self.supportModel = supportModel
    }
    
    var body: some View {
        GeometryReader { geo in
          ZStack{
              Ellipse()
                  .fill(Color.white)
                  .frame(width: 500, height: 300)
              Rectangle()
                  .fill(Color.white)
                  .frame(width: 500, height: 500)
                  .offset(y: 250)
           
                VStack {
                    Color.clear.frame(height: geo.size.height / 2.7)
                    HStack { //HStack - Director, Rating, Genre
                        Text(self.viewModel?.director ?? "loading")
                            .modifier(GeneralText(size:15))
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.01)
                            .offset(y:20)
                            .frame(width: 120, height: 50)
                    
                        StarIcon(self.viewModel?.userRating ?? "0")
                            .scaleEffect(1.5)
                            .frame(width: 90, height: 50)
                            .offset(y:-10)

                        Text(self.viewModel?.genre ?? "loading")
                            .multilineTextAlignment(.center)
                            .offset(y:20)
                            .modifier(GeneralText(size:12))
                            .frame(width: 120, height: 50)
                    }
                    .padding(.bottom, 20)
                    
                    HStack (spacing: 30) {
                        Button(action: {
                            withAnimation {
                                self.summaryPage = true
                                self.commentPage = false
                            }
                        }) {
                            Text("Summary")
                                .modifier(GeneralText(size: 15, color: self.summaryPage ? .white : .black))
                                .padding(5)
                                .background(self.summaryPage ? MyColor.darkGray : MyColor.lightlightGray)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            withAnimation {
                                self.summaryPage = false
                                self.commentPage = true
                            }
                        }) {
                            Text("Comments")
                                .modifier(GeneralText(size:15, color: self.commentPage ? .white : .black))
                                .padding(5)
                                .background(self.commentPage ? MyColor.darkGray : MyColor.lightlightGray)
                                .cornerRadius(10)
                                .offset(x:5)
                        }
                    }
                    .padding(.bottom, 20)
                    
                    VStack {
                        if !self.commentPage {
                            Text(self.viewModel?.cast ?? "loading cast")
                                .multilineTextAlignment(.center)
                                .modifier(GeneralText(size:15))
                                .padding(.bottom, 10)
                                .padding(.horizontal, 30)
                            
                            Text(self.viewModel?.synopsis ?? "loading summary")
                                .lineLimit(nil)
                                .minimumScaleFactor(0.01)
                                .modifier(GeneralText(size:12))
                                .padding(.horizontal, 80)
                        } else {
                            CommentView(commentModel: self.supportModel)
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}
