//
//  SummaryModel.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI
//import Combine

struct SummaryCellVM {
    private let item: MovieSummaryResponse.Movie
    
    init(item: MovieSummaryResponse.Movie) {
        self.item = item
    }
    
    var title: String {
        return String(item.title)
    }
    
    var thumb: String {
        return String(item.thumb)
    }
    
    var grade: String {
        return String(item.grade)
    }
    
    var userRating: String {
        return String(format: "%.1f", item.user_rating)
    }
    
    var movieId: String {
        return String(item.id)
    }
    
    var releaseDate: String {
        return item.date
    }
}
