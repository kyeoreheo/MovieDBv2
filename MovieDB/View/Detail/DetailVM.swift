//
//  DetailViewModel.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Foundation
import Combine

class DetailVM: ObservableObject {
    @Published var movieId: String = ""// [String] = []
    @Published var dataSource: DetailCardVM?

    private let movieFetcher: MovieFetchable
    private var disposables = Set<AnyCancellable>()
    

    init(movieFetcher: MovieFetcher, movieId: String = "") {
        self.movieFetcher = movieFetcher
        fetchDetail(forId: movieId)
    }

    func fetchDetail(forId id: String) {
        print("I am \(self), \(id)")
        movieFetcher.movieDetail(forId: id)
        .map { DetailCardVM.init(item: $0) }
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [weak self] value in
                guard let strongSelf = self else { return }
                switch value {
                case .failure:
                    print("couldn't load movie")
                case .finished:
                    break
                }
            },
            receiveValue: { [weak self] result in
                guard let strongSelf = self else { return }
                strongSelf.dataSource = result
            })
            .store(in: &disposables)

    }

}
