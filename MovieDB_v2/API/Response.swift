//
//  Response.swift
//  MovieDB
//
//  Copyright © 2020 Kyeore Heo. All rights reserved.
//
import Foundation

struct MovieResponse: Codable {
    var page: Int
    var results: [Movie]
    var total_pages: Int
    var total_results: Int
}

struct Movie: Codable {
    var id: Int
    var video: Bool
    var vote_count: Int
    var vote_average: Double
    var title: String
    var release_date: String
    var original_language: String
    var original_title: String
    var genre_ids : [Int]
    var backdrop_path: String
    var adult: Bool
    var overview: String
    var poster_path: String
    var popularity: Double
    var media_type: String
}
