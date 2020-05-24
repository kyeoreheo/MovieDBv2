//
//  CurrentMovie.swift
//  MovieDB
//
//  Created by Kyo on 3/8/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
import Foundation

class CurrentMovie: ObservableObject {
    @Published var movieId = ""
    @Published var showingDetail = false
    @Published var index = 0
}
