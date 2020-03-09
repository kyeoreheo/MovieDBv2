//
//  StarIcon.swift
//  MovieDB
//
//  Created by Kyo on 3/7/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
import SwiftUI

struct StarIcon: View {
    let number: String
    
    init(_ number: String) {
        self.number = number
    }
    
    var body: some View {
        ZStack {
            Image("star2")
            .resizable()
            .frame(width: 50, height: 50)
            Text(number)
            .modifier(GeneralText(size: 15))
            .offset(y:3)
        }
    }
}

struct StarIcon_Previews: PreviewProvider {
    static var previews: some View {
        StarIcon("6.6")
    }
}
