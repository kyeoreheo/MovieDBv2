//
//  CommentCell.swift
//  MovieDB
//
//  Created by Kyo on 3/8/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
import SwiftUI

struct CommentCell: View {
    private let viewModel: CommentCellVM

    init(viewModel: CommentCellVM) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack{
                Text(self.viewModel.writer)
                    .modifier(GeneralText(size:15))
                StarIcon(self.viewModel.rating)
                    .scaleEffect(0.8)
                Spacer()
                Text(convertTime(timeStamp: self.viewModel.timestamp))
                    .modifier(GeneralText())
            }
            Text(self.viewModel.comment)
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

