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
    
    var grade: String {
        return String(item.grade)
    }
    
    var cast: String {
        return String(item.actor)
    }
    var userRating: String {
        return String(item.user_rating)
    }
    var audience: String {
        return String(item.audience)
    }
    
    var synopsis: String {
        return String(item.synopsis)
    }
    
    var duration: Int {
        return item.duration
    }
    
    var director: String {
        return item.director
    }
    
    var genre: String {
        return item.genre
    }
    
    var releaseDate: String {
        return item.date
    }
    
}
