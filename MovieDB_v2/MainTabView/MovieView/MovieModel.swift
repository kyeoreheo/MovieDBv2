//
//  MovieModel.swift
//  MovieDB_v2
//
//  Copyright © 2020 Kyeore Heo. All rights reserved.

import Foundation
import Combine

class MovieModel: ObservableObject {
    @Published var type: String = "week"
    @Published var dataSource: [MovieCellVM] = [] 
    @Published var movieId: [String] = []
    
    private let movieFetcher: MovieFetchable
    private var disposables = Set<AnyCancellable>()
    
    init(movieFetcher: MovieFetchable, type: String) {
        self.type = type
        self.movieFetcher = movieFetcher
        $type
        .dropFirst(1)
        .sink(receiveValue: fetchSummary(forType: ))
        .store(in: &disposables)
        fetchSummary(forType: self.type)
    }
    
    func fetchSummary(forType type: String) {
        movieFetcher.movieSummary(forType: type)
            .map { $0.results.map(MovieCellVM.init) }
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [weak self] value in
                guard let strongSelf = self else { return }
                switch value {
                case .failure:
                    strongSelf.dataSource = []
                case .finished:
                    break
                }
            },
            receiveValue: { [weak self] result in
                guard let strongSelf = self else { return }
                strongSelf.dataSource = result
                strongSelf.movieIdGenerator()
            }
        )
        .store(in: &disposables)
    }
    
    func movieIdGenerator() {
        movieId = []
        dataSource.forEach {
            movieId.append($0.id)
        }
    }
}
