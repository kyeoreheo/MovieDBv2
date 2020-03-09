//
//  RankIcon.swift
//  MovieDB
//
//  Created by Kyo on 3/8/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
import SwiftUI

struct RankIcon: View {
    let number: String
    
    init(_ number: String) {
        self.number = number
    }
    
    var body: some View {
        ZStack {
            Image("rank")
            .resizable()
            .frame(width: 50, height: 50)
            .offset(y:3)
            Text(number)
            .modifier(GeneralText(size: 15))
        }
    }
}

struct RankIcon_Previews: PreviewProvider {
    static var previews: some View {
        RankIcon("1")
    }
}
