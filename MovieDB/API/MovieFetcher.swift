//
//  MovieFetcher.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Foundation
import Combine

protocol MovieFetchable {
    //-1 popularity -2 curation -3 release date
    func movieSummary (forType type: Int) -> AnyPublisher<MovieSummaryResponse, MovieError>
    func movieDetail (forId id: String) -> AnyPublisher<MovieDetailResponse, MovieError>
    func comment (forId id: String) -> AnyPublisher<CommentResponse, MovieError>
}

class MovieFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

// MARK: - fetching movies with URL
extension MovieFetcher: MovieFetchable {
    
    func movieSummary(forType type: Int) -> AnyPublisher<MovieSummaryResponse, MovieError> {
        return movieAPICall(with: movieSummaryCall(withType: type))
    }
    
    func movieDetail(forId id: String) -> AnyPublisher<MovieDetailResponse, MovieError> {
        return movieAPICall(with: movieDetailCall(withId: id))
    }
    
    func comment(forId id: String) -> AnyPublisher<CommentResponse, MovieError> {
        return movieAPICall(with: comentCall(withId: id))
    }
    
    private func movieAPICall<T>(with url: URL)
        -> AnyPublisher<T, MovieError> where T: Decodable {
        return session.dataTaskPublisher(for: URLRequest(url: url))
                .mapError { .network(description: $0.localizedDescription) }
                .flatMap(maxPublishers: .max(1)) { decode($0.data) }
                .eraseToAnyPublisher()
    }
}

// MARK: - organizing API Calls
extension MovieFetcher {
    struct MovieAPI {
        static let scheme = "https://"
        static let baseURL = "connect-boxoffice.run.goorm.io"
    }
    //connect-boxoffice.run.goorm.io/comments?id=5a54c1e9e8a71d136fb5376c
    func movieSummaryCall(withType type: Int) -> URL {
        let path = "/movies?order_type=\(type)"
        let currentURL = MovieAPI.scheme + MovieAPI.baseURL + path
        
        guard let resourceURL = URL(string: currentURL)
        else { fatalError() }
        return resourceURL
    }
    
    func movieDetailCall(withId id: String) -> URL {
        let path = "/movie?id=" + id
        let currentURL = MovieAPI.scheme + MovieAPI.baseURL + path

        guard let resourceURL = URL(string: currentURL)
        else { fatalError() }
        return resourceURL
    }

    func comentCall(withId id: String) -> URL {
        let path = "/comments?id=" + id
        let currentURL = MovieAPI.scheme + MovieAPI.baseURL + path

        guard let resourceURL = URL(string: currentURL)
        else { fatalError() }
        return resourceURL
    }
}

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, MovieError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970

    return Just(data)
            .decode(type: T.self, decoder: decoder)
            .mapError { .parsing(description: $0.localizedDescription) }
            .eraseToAnyPublisher()
}
