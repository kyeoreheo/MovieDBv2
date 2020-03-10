//
//  CommentCellVM.swift
//  MovieDB
//
//  Created by Kyo on 3/8/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
import SwiftUI

struct CommentCellVM {
    private let item: CommentResponse.Comment
    
    init(item: CommentResponse.Comment) {
          self.item = item
    }
    
    var rating: String { String(format: "%1.f",item.rating) }
    var comment: String { String(item.contents) }
    var timestamp: Double { item.timestamp }
    var writer: String { item.writer }
}
