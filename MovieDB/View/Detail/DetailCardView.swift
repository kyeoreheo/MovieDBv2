//
//  DetailFrame.swift
//  MovieDB
//
//  Created by Kyo on 3/8/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI

struct DetailCardView: View {
    @ObservedObject var commentModel: CommentVM

    let userRating: String
    let director: String
    let genre: String
    let cast: String
    let synopsis: String
    
    @State var commentPage = false
    
    var body: some View {
        VStack{
          ZStack{
              Ellipse()
                  .fill(Color.white)
                  .frame(width: 500, height: 300)
              Rectangle()
                  .fill(Color.white)
                  .frame(width: 500, height: 500)
                  .offset(y: 250)
           
                VStack {
                    HStack { //HStack - Director, Rating, Genre
                        Text(self.director)
                            .modifier(GeneralText(size:15))
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.01)
                            .offset(y:20)
                            .frame(width: 120, height: 50)
                    
                        StarIcon(userRating)
                            .scaleEffect(1.5)
                            .frame(width: 90, height: 50)
                            .offset(y:-10)

                        Text(self.genre)
                            .multilineTextAlignment(.center)
                            .offset(y:20)
                            .modifier(GeneralText(size:12))
                            .frame(width: 120, height: 50)
                    } //HStack - Director, Rating, Genre
                    .position(x: 250, y: 320)
                    HStack (spacing: 30){
                        Button(action: {
                            withAnimation {
                                self.commentPage = false
                            }
                        }) {
                            Text("Summary")
                                .modifier(GeneralText(size: 15, color: self.commentPage ? .black : .white))
                                .padding(5)
                                .background(self.commentPage ? MyColor.lightlightGray :     MyColor.darkGray)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            withAnimation {
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


                    
                    .position(x: 250, y: 180)
                    VStack {
                        if !self.commentPage {
                            Text(self.cast)
                                .multilineTextAlignment(.center)
                                .modifier(GeneralText(size:15))
                                .padding(.bottom, 10)
                                .position(x: 250, y: 20)
                            
                            
                            Text(self.synopsis)
                                .lineLimit(nil)
                                .minimumScaleFactor(0.01)
                                .modifier(GeneralText(size:12))
                                .padding(.horizontal, 80)
                                .position(x: 250, y: -70)
                        } else {
                            CommentView(commentModel: self.commentModel)
                        }
                    }
                .frame(height: 400)
                }
            }
        }
    }
}

//struct DetailCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailCardView(userRating: "5.5", director: "장창원", genre: "action", cast: "현빈(황지성), 유지태(박희수 검사), 배성우(고석동)", synopsis: "Hkjkjijij09j90jijoisdufmsoiadasldkfjaskldfjaslkfjasldkfjslkdfjsdlkfjsdlkfjsldkoidfdiofmoifmusdiofmasoidfdiofmasoidfdiofmasoidfiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmasoifdiofmoifmusdiofmasoidfdiofmasoidfdiofmasoidfiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmasoifdiofmoifmusdiofmasoidfdiofmasoidfdiofmasoidfiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmasoidfdiofmfdjsfjmI")
//    }
//}
