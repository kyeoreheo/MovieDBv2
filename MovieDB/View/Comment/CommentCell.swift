//
//  CommentCell.swift
//  MovieDB
//
//  Created by Kyo on 3/8/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI

struct CommentCell: View {
    let wiriter: String
    let rating: String
    let timestamp: Double
    let comment: String
    
    var body: some View {
        VStack {
            HStack{
                Text(self.wiriter)
                    .modifier(GeneralText(size:15))
                StarIcon(self.rating)
                    .scaleEffect(0.8)
                Spacer()
                Text(convertTime(timeStamp: self.timestamp))
                    .modifier(GeneralText())

            }
            Text(self.comment)
                .modifier(GeneralText(size:20))


        }.padding(.horizontal, 80)
    }
    
    func convertTime(timeStamp : Double) -> String {

        let date = NSDate(timeIntervalSince1970: timeStamp)

        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd MMM YY, hh:mm"


        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        CommentCell(wiriter: "Kyo", rating: "5.5", timestamp: 1515748870.80631, comment: "sdlfkjsdkfdsjfdksfjsklfjd")
    }
}
