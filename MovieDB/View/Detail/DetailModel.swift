//
//  DetailViewModel.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
import Foundation
import Combine

class DetailModel: ObservableObject {
    @Published var dataSource: DetailCardVM?

    private let movieFetcher: MovieFetchable
    private var disposables = Set<AnyCancellable>()

    init(movieFetcher: MovieFetcher, movieId: String = "") {
        self.movieFetcher = movieFetcher
        fetchDetail(forId: movieId)
    }

    func fetchDetail(forId id: String) {
        movieFetcher.movieDetail(forId: id)
        .map { DetailCardVM.init(item: $0) }
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { value in
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
            }
        )
        .store(in: &disposables)
    }

}
