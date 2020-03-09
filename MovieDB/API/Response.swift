//
//  Response.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Foundation


struct MovieSummaryResponse: Codable {
    var movies: [Movie]
    
    struct Movie: Codable {
        var grade: Int
        var title: String
        var thumb: String
        var user_rating: Double
        var reservation_grade: Int
        var id: String
        var reservation_rate: Double
        var date: String
    }
}

struct MovieDetailResponse: Codable {
    var grade: Int
    var actor: String
    var title: String
    var user_rating: Double
    var reservation_grade: Int
    var audience: Int
    var synopsis: String
    var image: String
    var id: String
    var duration: Int
    var director: String
    var reservation_rate: Double
    var genre: String
    var date: String
}

struct CommentResponse: Codable {
    //var movie_id: String
    var comments: [Comment]
    
    struct Comment: Codable {
        var rating: Int
        var contents: String
        var timestamp: Double
        var movie_id: String
        var writer: String
        var id: String
    }
}

