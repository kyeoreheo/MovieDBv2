//
//  NavigationBar.swift
//  MovieDB
//
//  Created by Kyo on 3/7/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI

extension UINavigationController {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        let darkGray = MyColor.darkGray

        var standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = .black
        standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        standardAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.scrollEdgeAppearance = standardAppearance
        navigationBar.standardAppearance = standardAppearance
        //navigationBar.sizeThatFits(.init(width: 0, height: 0))
    }
}
