//
//  CustomView.swift
//  MovieDB_v2
//
//  Copyright © 2020 Kyeore Heo. All rights reserved.
//

import UIKit

class CustomView {
    static let shared = CustomView()
    
    func header(filter: String, target: Any, presentDay: Selector, presentWeek: Selector) -> UIView {
        let view = UIView()
        view.backgroundColor = .black
        
        let logoLabel = UILabel()
        logoLabel.text = "MovieDB"
        logoLabel.textColor = .white
        logoLabel.font = UIFont.boldSystemFont(ofSize: 24)

        let dayButton = UIButton()
        dayButton.setTitle("DAY", for: .normal)
        dayButton.setTitleColor(filter == "day" ? .black : .white , for: .normal)
        dayButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        dayButton.layer.backgroundColor = filter == "day" ? UIColor.white.cgColor :  UIColor.grey7.cgColor
        dayButton.layer.cornerRadius = filter == "day" ? 15 : 5
        dayButton.layer.masksToBounds = true
        dayButton.addGestureRecognizer(UITapGestureRecognizer(target: target, action: presentDay))
        
        let weekButton = UIButton()
        weekButton.setTitle("WEEK", for: .normal)
        weekButton.setTitleColor(filter == "week" ? .black : .white, for: .normal)
        weekButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        weekButton.layer.backgroundColor = filter == "week" ? UIColor.white.cgColor :  UIColor.grey7.cgColor
        weekButton.layer.cornerRadius = filter == "week" ? 15: 5
        weekButton.layer.masksToBounds = true
        weekButton.addGestureRecognizer(UITapGestureRecognizer(target: target, action: presentWeek))
        
        view.addSubview(logoLabel)
        logoLabel.adjustsFontSizeToFitWidth = true
        logoLabel.anchor(left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         paddingLeft: 20,
                         paddingBottom: 10)
        
        view.addSubview(weekButton)
        weekButton.setDimensions(width: 60, height: 30)
        weekButton.anchor(bottom: view.bottomAnchor,
                          right: view.rightAnchor,
                          paddingBottom: 10,
                          paddingRight: 20)
        
        view.addSubview(dayButton)
        dayButton.setDimensions(width: 50, height: 30)
        dayButton.anchor(bottom: view.bottomAnchor,
                         right: weekButton.leftAnchor,
                         paddingBottom: 10,
                         paddingRight: 10)
        
        return view
    }
    
    func starView(number: Double) -> UIView {
        let view = UIView()
        
        let imageView = UIImageView()
        imageView.image = UIImage(named:"star")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true

        let label = UILabel()
        label.text = String(number)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 15)
          
        view.addSubview(imageView)
        imageView.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor)
          
        view.addSubview(label)
        label.center(inView: imageView)
        
        return view
    }
    
    func likeView(number: Int, ratio: CGFloat) -> UIView {
        let view = UIView()

        let imageView = UIImageView()
        imageView.image = UIImage(named:"like")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        let cover = UIImageView()
        cover.backgroundColor = .likeRed
        cover.clipsToBounds = true

        let label = UILabel()
        label.text = String(number)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 15 * ratio)

        view.addSubview(imageView)
        imageView.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor)
        
        view.addSubview(cover)
        cover.anchor(top: view.topAnchor,
                     left: view.leftAnchor,
                     bottom: view.bottomAnchor,
                     right: view.rightAnchor,
                     paddingTop: 8,
                     paddingLeft: 8,
                     paddingBottom: 16,
                     paddingRight: 8)

        view.addSubview(label)
        label.centerX(inView: imageView,
                      topAnchor: view.topAnchor,
                      paddingTop: 16 * ratio)

        return view
    }
}
