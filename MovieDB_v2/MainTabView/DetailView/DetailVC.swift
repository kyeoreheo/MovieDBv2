//
//  DetailVC.swift
//  MovieDB_v2
//
//  Copyright © 2020 Kyeore Heo. All rights reserved.
//

import UIKit
import Combine

class DetailVC: UIViewController {
    // MARK:- Properties
    public var movie: MovieCellVM? {
        didSet {
            guard let poster = movie?.poster else {return}
            fetchImage(urlString: "https://image.tmdb.org/t/p/w500/" + poster)
            configureUI()
        }
    }
    
    private var imageSubscriber: AnyCancellable?
    
    private let background: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .orange
        return imageView
    }()
    private let cover: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 50
        return imageView
    }()
    private let overView: UILabel = {
        let label = UILabel()
        label.text = "this is label"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    private var movieTitle: UILabel = {
        let label = UILabel()
        label.text = "movieTitle"
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    // MARK:- Lifecycle
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
    }
    // MARK:- Configures
    func configureUI() {
        view.addSubview(background)
        background.setDimensions(width: view.frame.width, height: view.frame.height)
        background.anchor(top: view.topAnchor,
                          left: view.leftAnchor,
                          paddingTop: -view.frame.height/3)
        
        view.addSubview(cover)
        cover.anchor(top: view.topAnchor,
                     left: view.leftAnchor,
                     bottom: view.bottomAnchor,
                     right: view.rightAnchor,
                     paddingTop: 300)
        
        view.addSubview(movieTitle)
        movieTitle.text = movie?.title
        movieTitle.centerX(inView: cover,
                           topAnchor: cover.topAnchor,
                           paddingTop: 50)
        movieTitle.anchor(left: view.leftAnchor,
                          right: view.rightAnchor,
                          paddingLeft: 20,
                          paddingRight: 20)
        
        view.addSubview(overView)
        overView.adjustsFontSizeToFitWidth = true
        overView.text = movie?.overview
        overView.anchor(top: movieTitle.bottomAnchor,
                        left: view.leftAnchor,
                        right: view.rightAnchor,
                        paddingTop: 50,
                        paddingLeft: 20,
                        paddingRight: 20)
    }
    
    // MARK:- Helpers
    func fetchImage(urlString: String) {
        let urlImageModel = UrlImageModel(urlString: urlString)
        imageSubscriber = urlImageModel.objectWillChange
        .sink { _ in
            self.background.image = urlImageModel.image
        }
    }
}


