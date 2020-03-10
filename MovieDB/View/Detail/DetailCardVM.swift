//
//  MovieItem.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
import SwiftUI

struct DetailCardVM {
    private let item: MovieDetailResponse
    
    init(item: MovieDetailResponse) {
        self.item = item
    }
    
    var grade: String { String(item.grade) }
    var cast: String { String(item.actor) }
    var userRating: String { String(item.user_rating) }
    var audience: String { String(item.audience) }
    var synopsis: String { String(item.synopsis) }
    var duration: Int { item.duration }
    var director: String { item.director }
    var genre: String { item.genre }
    var releaseDate: String { item.date }
}
