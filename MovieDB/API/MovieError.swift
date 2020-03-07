//
//  MovieError.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
import Foundation

enum MovieError: Error {
    case parsing(description: String)
    case network(description: String)
}
