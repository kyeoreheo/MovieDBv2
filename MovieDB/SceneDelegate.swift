//
//  SceneDelegate.swift
//  MovieDB
//
//  Created by Kyo on 3/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let movieFetcher = MovieFetcher()
        let commentVM = CommentModel(movieFetcher: movieFetcher)
        let summaryVM = SummaryModel(movieFetcher: movieFetcher)
        let detailVM = DetailModel(movieFetcher: movieFetcher)
        let currentMovie = CurrentMovie()
        
        let contentView = ContentView()
            .environmentObject(summaryVM)
            .environmentObject(detailVM)
            .environmentObject(commentVM)
            .environmentObject(currentMovie)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

