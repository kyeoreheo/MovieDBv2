//
//  FavoritesCVC.swift
//  MovieDB_v2
//
//  Copyright © 2020 Kyeore Heo. All rights reserved.
//

import UIKit
import Combine

class FavoritesCVC: UICollectionViewController {
    // MARK:- Properties
    public var mainTabView: MainTabView?

    private var movieSubscriber: AnyCancellable?
    private var viewModel = [MovieCellVM]() {
        didSet {
            filterFavoriteMovies()
            collectionView.reloadData()
        }
    }
    
    private var favoriteMovies = [MovieCellVM]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let reuseIdentifier = "cardCell"
    
    private let cover: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorites"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        configureUI()
        fetchMovie()
    }
    // MARK:- Selectors

    // MARK:- Configures
    func configure() {
        collectionView.contentInset = UIEdgeInsets(top: 100, left: 10, bottom: 0, right: 10)
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        navigationController?.navigationBar.isHidden = true
    }
    
    func configureUI() {
        collectionView.backgroundColor = .white
        
        view.addSubview(cover)
        cover.setDimensions(width: view.frame.width, height: 100)
        cover.anchor(top: view.topAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor)
        
        view.addSubview(titleLabel)
        titleLabel.centerX(inView: cover,
                           topAnchor: cover.topAnchor,
                           paddingTop: 60)
    }
    // MARK:- Helpers
    private func fetchMovie() {
        let myModel = MovieModel(movieFetcher: MovieFetcher(), type: "day")
        movieSubscriber = myModel.objectWillChange
        .sink{ _ in
            self.viewModel = myModel.dataSource
        }
    }
    
    private func filterFavoriteMovies() {
        guard let originalArray = mainTabView?.favoriteMovies else {
            return
        }
        
        favoriteMovies.removeAll()
        viewModel.forEach { viewModelElement in
            originalArray.forEach { originalArrayElement in
                if viewModelElement.id == originalArrayElement {
                    favoriteMovies.append(viewModelElement)
                    favoriteMovies = favoriteMovies.removingDuplicates()
                }
            }
        }
    }
}

// MARK:- Extensions
extension FavoritesCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2.2, height: view.frame.width/2.2 * 1.5)
    }
}

extension FavoritesCVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteMovies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CardCell
        cell.movie = favoriteMovies[indexPath.row]
        return cell
    }
}
