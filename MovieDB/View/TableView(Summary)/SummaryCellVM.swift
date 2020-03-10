//
//  SummaryModel.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
import SwiftUI

struct SummaryCellVM {
    private let item: MovieSummaryResponse.Movie
    
    init(item: MovieSummaryResponse.Movie) {
        self.item = item
    }
    
    var title: String { item.title }
    var thumb: String { item.thumb}
    var grade: String { String(item.grade) }
    var userRating: String { String(format: "%.1f", item.user_rating) }
    var criticsRating: String { String(format: "%.1f", item.reservation_rate) }
    var rank: String { String(item.reservation_grade) }
    var movieId: String { item.id }
    var releaseDate: String { item.date }
}
