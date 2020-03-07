//
//  SummaryVM.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Foundation
import Combine

class SummaryVM: ObservableObject {
    @Published var type: Int = 0
    @Published var dataSource: [SummaryCellVM] = []
    @Published var movieId: [String] = []
    
    private let movieFetcher: MovieFetchable
    private var disposables = Set<AnyCancellable>()
    
    init(movieFetcher: MovieFetchable) {
        self.movieFetcher = movieFetcher
        $type
        .dropFirst(1)
        .sink(receiveValue: fetchSummary(forType: ))
        .store(in: &disposables)
    }
    
    func fetchSummary(forType type: Int) {
        movieFetcher.movieSummary(forType: type)
        .map { $0.movies.map(SummaryCellVM.init) }
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
            })
            .store(in: &disposables)
    }
    
    func movieIdGenerator() {
        dataSource.forEach {
            movieId.append($0.movieId)
        }
    }
}
