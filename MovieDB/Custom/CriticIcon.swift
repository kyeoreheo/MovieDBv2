//
//  CriticIcon.swift
//  MovieDB
//
//  Created by Kyo on 3/8/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI

struct CriticIcon: View {
    let number: String
    
    init(_ number: String) {
        self.number = number
    }
    
    var body: some View {
        ZStack {
            Image("critic")
            .resizable()
            .frame(width: 50, height: 50)
                .offset(x:4, y:3)
            Text(number)
            .modifier(GeneralText(size: 15))
            .offset(y:3)
        }
    }
}

struct CriticIcon_Previews: PreviewProvider {
    static var previews: some View {
        CriticIcon("3.3")
    }
}
