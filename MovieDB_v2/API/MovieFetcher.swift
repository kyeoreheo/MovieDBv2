//
//  MovieFetcher.swift
//  MovieDB
//
//  Copyright © 2020 Kyeore Heo. All rights reserved.
//
import Foundation
import Combine

protocol MovieFetchable {
    func movieSummary (forType type: String) -> AnyPublisher<MovieResponse, MovieError>
}

class MovieFetcher {
    private let session: URLSession
    private let scheme = "https://"
    private let APIkey = "d77210b201da01755df1679c20e5ab1a"
    private let baseURL = "api.themoviedb.org/3"
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

// MARK: - fetching movies with URL
extension MovieFetcher: MovieFetchable {
    func movieSummary(forType type: String) -> AnyPublisher<MovieResponse, MovieError> {
        return movieAPICall(with: movieSummary(withType: type))
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
    //type: day, week
    func movieSummary(withType type: String) -> URL {
        let path = "/trending/movie/\(type)?api_key="
        let currentURL = scheme + baseURL + path + APIkey
        guard let resourceURL = URL(string: currentURL)
        else { fatalError("trending movie API address is wrong") }
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
