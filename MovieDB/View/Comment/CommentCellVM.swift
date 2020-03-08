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
    
    var rating: String {
        return String(format: "%1.f",item.rating)
    }
    
    var comment: String {
        return String(item.contents)
    }
    
    var tiemstamp: Int {
        return item.timestamp
    }
    
    var writer: String { item.writer }
//    var rating: Int
//    var contents: String
//    var timestamp: Int
//    var movie_id: String
//    var writer: String
}
