//
//  GenerConverter.swift
//  MovieDB_v2
//
//  Copyright © 2020 Kyeore Heo. All rights reserved.
//

class GenreConverter {
    func convert(_ id: Int) -> String {
        var gener = ""
        switch id {
        case 28:
            gener = "Action"
        case 12:
            gener = "Adventure"
        case 35:
            gener = "Comedy"
        case 80:
            gener = "Crime"
        case 99:
            gener = "Documentary"
        case 18:
            gener = "Drama"
        case 10751:
            gener = "Family"
        case 14:
            gener = "Fantasy"
        case 36:
            gener = "History"
        case 27:
            gener = "Horror"
        case 10402:
            gener = "Music"
        case 9648:
            gener = "Mystery"
        case 10749:
            gener = "Romance"
        case 878:
            gener = "Science Fiction"
        case 10770:
            gener = "TV Movie"
        case 53:
            gener = "Thriller"
        case 10752:
            gener = "War"
        case 37:
            gener = "Western"
        default:
            gener = "N/A"
        }
        return gener
    }
}
