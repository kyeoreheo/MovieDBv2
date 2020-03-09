//
//  CommentView.swift
//  MovieDB
//
//  Created by Kyo on 3/8/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI

struct CommentView: View {
    @ObservedObject var commentModel: CommentVM
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            Text("\(self.commentModel.dataSource.count)")
            ForEach(0..<commentModel.dataSource.count) {
                //Text(self.commentModel.dataSource[$0].movieId)
                CommentCell(wiriter: self.commentModel.dataSource[$0].writer,
                            rating: self.commentModel.dataSource[$0].rating,
                            timestamp: self.commentModel.dataSource[$0].timestamp,
                            comment: self.commentModel.dataSource[$0].comment)
            }




        }.frame(height: 400)
    }
}
