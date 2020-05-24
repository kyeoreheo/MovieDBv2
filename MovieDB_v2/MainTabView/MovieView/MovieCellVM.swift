//
//  MovieCellVM.swift
//  MovieDB_v2
//
//  Copyright © 2020 Kyeore Heo. All rights reserved.

struct MovieCellVM: Hashable {
    var hashValue: Int {
        return id.hashValue
    }

    static func == (lhs: MovieCellVM, rhs: MovieCellVM) -> Bool {
        return lhs.id ==  rhs.id
    }

    private let item: Movie
    
    init(item: Movie) { self.item = item }
    
    var id: String { String(item.id) }
    var vote: Int { item.vote_count }
    var rating: Double { item.vote_average }
    var title: String { item.title }
    var releaseDate: String { item.release_date }
    var genre: [Int] { item.genre_ids }
    var backdrop: String { item.backdrop_path }
    var poster: String { item.poster_path }
    var adult: Bool { item.adult }
    var overview: String { item.overview }
}
