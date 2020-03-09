//
//  CommentVM.swift
//  MovieDB
//
//  Created by Kyo on 3/8/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI
import Combine

class CommentVM: ObservableObject {
    @Published var dataSource: [CommentCellVM] = []

    private let movieFetcher: MovieFetchable
    private var disposables = Set<AnyCancellable>()

    init(movieFetcher: MovieFetcher, movieId: String = "") {
        self.movieFetcher = movieFetcher
        fetchComment(forId: movieId)
    }
    
    func fetchComment(forId id: String) {
        print(id)
        movieFetcher.comment(forId: id)
            .map { $0.comments.map(CommentCellVM.init) }
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [weak self] value in
                guard let strongSelf = self else { return }
                switch value {
                case .failure:
                    strongSelf.dataSource = []
                    print("Couldn't fetch comments")
                case .finished:
                    print("Successfully fetch comments")
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
