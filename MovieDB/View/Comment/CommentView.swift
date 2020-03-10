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
            if self.commentModel.dataSource.count > 0 {
                ForEach(0..<commentModel.dataSource.count) {
                    CommentCell(viewModel: self.commentModel.dataSource[$0])
                }
            } else {
                Text("loading comments")
                    .frame(width: 400)
                    .modifier(GeneralText())
            }
        }
        .frame(height: 350)
    }
}
