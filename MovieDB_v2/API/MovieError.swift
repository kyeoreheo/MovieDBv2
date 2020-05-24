//
//  MovieError.swift
//  MovieDB
//
//  Copyright © 2020 Kyeore Heo. All rights reserved.
//
import Foundation

enum MovieError: Error {
    case parsing(description: String)
    case network(description: String)
}
