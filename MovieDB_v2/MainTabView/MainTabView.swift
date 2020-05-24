//
//  MainTabView.swift
//  MovieDB_v2
//
//  Copyright © 2020 Kyeore Heo. All rights reserved.

import UIKit

class MainTabView: UITabBarController {
    // MARK: - properties
    public var favoriteMovies = [String]() {
        didSet{
            UserDefaults.standard.set(favoriteMovies, forKey: "favoriteMovies")
        }
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteMovies = UserDefaults.standard.stringArray(forKey: "favoriteMovies") ?? [String]()
        configureViewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    // MARK: - Selectors
    
    // MARK: - configures
    func configureViewControllers() {
        let moviesRootViewController = MoviesCVC(collectionViewLayout: UICollectionViewFlowLayout())
        moviesRootViewController.mainTabView = self
        let moviesCVC = UINavigationController(rootViewController: moviesRootViewController)
        moviesCVC.title = "Movies"
        
        let favortiesRootViewController = FavoritesCVC(collectionViewLayout: UICollectionViewFlowLayout())
        favortiesRootViewController.mainTabView = self
        let favoritesCVC = UINavigationController(rootViewController: favortiesRootViewController)
        favoritesCVC.title = "Favorites"
        viewControllers = [moviesCVC, favoritesCVC]
     }
}

extension UITabBarController {
    func createNavController(viewController: UIViewController, selected: UIImage, unselected: UIImage) -> UINavigationController{
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselected
        navController.tabBarItem.selectedImage = selected

        return navController
    }
}
