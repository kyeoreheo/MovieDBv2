//
//  Font.swift
//  MovieDB
//
//  Created by Kyo on 3/7/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
import SwiftUI

struct GeneralText: ViewModifier {
    var style: Font
    var color: Color
    
    init(size: CGFloat = 12, color: Color = .black) {
        self.style = .custom("GodoM", size: size)
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
        .font(style)
        .foregroundColor(color)
    }
}
