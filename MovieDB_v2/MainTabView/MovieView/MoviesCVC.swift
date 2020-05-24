//
//  MoviesCVC.swift
//  MovieDB_v2
//
//  Copyright © 2020 Kyeore Heo. All rights reserved.

import UIKit
import Combine
import AVFoundation

class MoviesCVC: UICollectionViewController {
    // MARK:- Properties
    public var mainTabView: MainTabView?
    
    private var ratio: CGFloat = 0.0;

    private var movieSubscriber: AnyCancellable?
    private var viewModel = [MovieCellVM]() {
        didSet { collectionView.reloadData() }
    }
    
    private var player: AVAudioPlayer?
    
    private let reuseIdentifier = "movieCell"

    private let cover: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .orange
        return imageView
    }()
    private var bagSpot: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        return imageView
    }()
    private var filter = "day" {
        didSet {
            UIView.animate(
                withDuration: 0.5,
                delay: 0.0,
                options: .curveEaseIn,
                animations: { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.header = CustomView.shared.header(filter: strongSelf.filter, target: strongSelf,
                                  presentDay: #selector(strongSelf.presentDay),
                                  presentWeek: #selector(strongSelf.presentWeek))
                    strongSelf.view.layoutIfNeeded()
                },
                completion: nil)
            fetchMovie()
            configureUI()
        }
    }
    private lazy var header = CustomView.shared.header(filter: filter, target:self,
                      presentDay: #selector(presentDay),
                      presentWeek: #selector(presentWeek))
    
    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
        fetchMovie()
    }

    // MARK:- Selectors
    @objc func presentDay() {
        filter = "day"
        playSound(sound: "buttonClick")
    }
    
    @objc func presentWeek() {
        filter = "week"
        playSound(sound: "buttonClick")

    }
    // MARK:- Configures
    private func configure() {
        navigationController?.navigationBar.isHidden = true
        collectionView.contentInset = UIEdgeInsets(top: 100, left: 0,
                                                   bottom: 0, right: 0)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        ratio = CGFloat(view.frame.height / 896.0)
    }
    
    private func configureUI() {
        collectionView.backgroundColor = .white
        view.addSubview(header)
        header.setDimensions(width: view.frame.width, height: 100)
        header.anchor(top: collectionView.topAnchor,
                      left: view.leftAnchor,
                      right: view.rightAnchor,
                      paddingTop: 0)
        
        view.addSubview(bagSpot)
        bagSpot.setDimensions(width: 50, height: 50)
        bagSpot.anchor(top: view.bottomAnchor,
                       right: view.rightAnchor,
                       paddingBottom: 50,
                       paddingRight: 50)
    }
    
    private func showPoster(_ index: Int) {
        print("DEBUG:- movie info", viewModel[index].title)
        let detailView = DetailVC()
        detailView.movie = viewModel[index]
        detailView.modalPresentationStyle = .popover
        present(detailView, animated: true)
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
    // MARK:- Helpers
    public func addToFavorites (poster: UIImageView, movieId: String) {
         view.addSubview(poster)
         poster.layer.cornerRadius = 15
         poster.setDimensions(width: 200, height: 325)
         poster.center(inView: view)
         view.layoutIfNeeded()
         
         UIView.animate(
             withDuration: 0.5,
             delay: 0.0,
             options: UIView.AnimationOptions.curveEaseOut,
             animations: { [weak self] in
                 guard let strongSelf = self else { return }
                 strongSelf.view.isUserInteractionEnabled = false
                 poster.center = strongSelf.bagSpot.center
                 poster.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
             }, completion: { finished in
             poster.removeFromSuperview()
             self.view.isUserInteractionEnabled = true
             })
         mainTabView?.favoriteMovies.append(movieId)
    }
     
    public func removeFromFavorites (movieId: String) {
         guard let originalArray = mainTabView?.favoriteMovies else { return }
         
         mainTabView?.favoriteMovies = originalArray.filter {
             $0 != movieId
         }
     }
    
    private func fetchMovie() {
        let myModel = MovieModel(movieFetcher: MovieFetcher(), type: filter)
        movieSubscriber = myModel.objectWillChange
        .sink{ _ in
            self.viewModel = myModel.dataSource
        }
    }
}

// MARK:- Extensions
extension MoviesCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height / 5)
    }
}

extension MoviesCVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
        cell.parent = self
        cell.ratio = ratio
        cell.movie = viewModel[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MovieCell
        else { return }
        showPoster(indexPath.row)
    }
}
