//
//  CardCell.swift
//  MovieDB_v2
//
//  Copyright © 2020 Kyeore Heo. All rights reserved.
//

import UIKit
import Combine

class CardCell: UICollectionViewCell {
    // MARK:- Properties
    public var movie: MovieCellVM? {
        didSet {
            guard let poster = movie?.poster else {return}
            fetchImage(urlString: "https://image.tmdb.org/t/p/w500/" + poster)
            configureUI()
        }
    }
    private var imageSubscriber: AnyCancellable?
        
    private var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .orange
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private var background: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
        imageView.layer.borderWidth = 0
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.opacity = 0.8
        imageView.clipsToBounds = true
        return imageView
    }()
    // MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK:- Selectors
    
    // MARK:- Configures
    private func configureUI() {
        addSubview(background)
        background.anchor(top: topAnchor,
                          left: leftAnchor,
                          bottom: bottomAnchor,
                          right: rightAnchor,
                          paddingTop: 0,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 0)
        
        addSubview(poster)
        poster.anchor(top: topAnchor,
                      left: leftAnchor,
                      bottom: bottomAnchor,
                      right: rightAnchor,
                      paddingTop: 5,
                      paddingLeft: 5,
                      paddingBottom: 5,
                      paddingRight: 5)
    }
    
    func generateGener(genres: [Int]?) -> String {
        guard let genres  = genres else { return "" }
        var result: String = ""
        genres.forEach{
            if GenreConverter().convert($0) != "N/A"{
                result = result + GenreConverter().convert($0) + ", "
            }
        }
        result = String(result.dropLast(2))
        return result
    }
    // MARK:- Helpers
    func fetchImage(urlString: String) {
        let urlImageModel = UrlImageModel(urlString: urlString)
        imageSubscriber = urlImageModel.objectWillChange
        .sink { _ in
            self.poster.image = urlImageModel.image
        }
    }
}
