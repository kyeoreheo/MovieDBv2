//
//  MovieCell.swift
//  MovieDB_v2
//
//  Copyright © 2020 Kyeore Heo. All rights reserved.
//

import UIKit
import Combine
import AVFoundation

class MovieCell: UICollectionViewCell {
    // MARK:- Properties
    public var pinned = false
    public var parent: MoviesCVC?
    private var player: AVAudioPlayer?
    public var ratio: CGFloat = 1 {
        didSet {
            configureUI()
        }
    }

    private var imageSubscriber: AnyCancellable?
    var movie: MovieCellVM? {
        didSet {
            guard let poster = movie?.poster else {return}
            fetchImage(urlString: "https://image.tmdb.org/t/p/w500/" + poster)
            checkPinnedMovie()
            configureUI()
        }
    }
    
    private var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .orange
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var pin: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pin")
        imageView.contentMode = .scaleToFill
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pinButton)))
        return imageView
    }()
    private var background: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.opacity = 0.8
        imageView.clipsToBounds = true
        return imageView
    }()
    private var title: UILabel = {
        let label = UILabel()
        label.text = "movieTitle"
        label.textColor = .black
        return label
    }()
    private var releaseDate: UILabel = {
        let label = UILabel()
        label.text = "releaseDate"
        label.textColor = .black
        return label
    }()
    private var genre: UILabel = {
        let label = UILabel()
        label.text = "genre"
        label.textColor = .black
        return label
    }()
    private let imageView = UIImageView()
    // MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pinButton() {
        guard let posterImage = poster.image,
              let movieId = movie?.id,
              let parent = parent
        else { return }
        playSound(sound: "pin")
        
        imageView.image = posterImage
        pinned.toggle()
        
        if pinned {
            pin.image = UIImage(named: "unpin")
            parent.addToFavorites(poster: imageView, movieId: movieId)
        } else {
            pin.image = UIImage(named: "pin")
            parent.removeFromFavorites(movieId: movieId)
        }
    }
    // MARK:- Configures
    private func configureUI() {
        let star = CustomView.shared.starView(number: movie?.rating ?? 0)
        let likes = CustomView.shared.likeView(number: movie?.vote ?? 0, ratio: ratio)
        
        addSubview(background)
        background.anchor(top: topAnchor,
                          left: leftAnchor,
                          bottom: bottomAnchor,
                          right: rightAnchor,
                          paddingTop: 0,
                          paddingLeft: 20,
                          paddingBottom: 0,
                          paddingRight: 20)
        
        addSubview(poster)
        poster.setDimensions(width: frame.width/4 * ratio, height: frame.width/4 * 1.5 * ratio)
        poster.centerY(inView: background,
                       leftAnchor: leftAnchor,
                       paddingLeft: 20 + 12)
        
        addSubview(title)
        title.text = movie?.title
        title.font = UIFont.boldSystemFont(ofSize: 24 * ratio)
        title.setDimensions(width: frame.width/3 * ratio, height: 20 * ratio)
        title.anchor(top: poster.topAnchor,
                     left: poster.rightAnchor,
                     right: rightAnchor,
                     paddingTop: 0,
                     paddingLeft: 16,
                     paddingRight: 24 + 8)
        
        addSubview(releaseDate)
        releaseDate.text = movie?.releaseDate
        releaseDate.font = UIFont.systemFont(ofSize: 15 * ratio)
        releaseDate.adjustsFontSizeToFitWidth = true
        releaseDate.anchor(top: title.bottomAnchor,
                           left: poster.rightAnchor,
                           paddingTop: 8,
                           paddingLeft: 16)
        
        addSubview(genre)
        genre.text = generateGener(genres: movie?.genre)
        genre.font = UIFont.systemFont(ofSize: 12 * ratio)
        genre.adjustsFontSizeToFitWidth = true
        genre.anchor(top: releaseDate.bottomAnchor,
                     left: poster.rightAnchor,
                     paddingTop: 8,
                     paddingLeft: 16)
        
        addSubview(star)
        star.setDimensions(width: 50 * ratio, height: 50 * ratio)
        star.anchor(top: genre.bottomAnchor,
                    left: poster.rightAnchor,
                    paddingTop: 16,
                    paddingLeft: 16)
        
        addSubview(likes)
        likes.setDimensions(width: 50 * ratio, height: 50 * ratio)
        likes.anchor(top: genre.bottomAnchor,
                     left: star.rightAnchor,
                     paddingTop: 24,
                     paddingLeft: 24)
        
        addSubview(pin)
        pin.setDimensions(width: 50 * ratio, height: 50 * ratio)
        pin.anchor(top: genre.bottomAnchor,
                   left: likes.rightAnchor,
                   paddingTop: 24,
                   paddingLeft: 24)
    }
    
    
    // MARK:- Helpers
    private func fetchImage(urlString: String) {
        let urlImageModel = UrlImageModel(urlString: urlString)
        imageSubscriber = urlImageModel.objectWillChange
        .sink { _ in
            self.poster.image = urlImageModel.image
        }
    }
    
    private func checkPinnedMovie() {
        guard let originalArray = parent?.mainTabView?.favoriteMovies,
            let movieId = movie?.id
        else { return }
        if originalArray.contains(movieId) {
            pinned = true
            pin.image = UIImage(named: "unpin")
        }
        configureUI()
    }
    
    private func generateGener(genres: [Int]?) -> String {
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
    
    private func playSound(sound: String?) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: "wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
