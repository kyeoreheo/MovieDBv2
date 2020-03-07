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
    @Published var movieId: [String] = []// [String] = []
    @Published var dataSource: [DetailCardVM] = []

    private let movieFetcher: MovieFetchable
    private var disposables = Set<AnyCancellable>()
    

    init(movieFetcher: MovieFetcher, movieId: [String]) {
        self.movieFetcher = movieFetcher
        self.movieId = movieId
    }

    //one to one fetch
    func fetchDetail() {
        print("before \(dataSource.count)")
        dataSource = []
        movieId.forEach {
            movieFetcher.movieDetail(forId: $0)
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
                    //strongSelf.dataSource = result
                    strongSelf.dataSource.append(result)
                })
                .store(in: &disposables)
        }
        print("after \(dataSource.count)")

    }

}
