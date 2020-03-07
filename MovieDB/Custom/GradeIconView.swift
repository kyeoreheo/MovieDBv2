//
//  Grade.swift
//  MovieDB
//
//  Created by Kyo on 3/7/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI

struct GradeIconView: View {
    let grade: String
    let circleColor: Color
    init(grade: String) {
        self.grade = grade
        if grade == "15" {
            self.circleColor = MyColor.darkYellow
        } else if grade == "19" {
            self.circleColor = MyColor.darkRed
        } else {
            self.circleColor = MyColor.darkBlue
        }
    }
    
    var body: some View {
        Text(self.grade)
        .foregroundColor(Color.white)
        .background(Circle()
        .fill(self.circleColor)
        .frame(width: 20, height: 20))
    }
}

struct GradeIconView_Previews: PreviewProvider {
    static var previews: some View {
        GradeIconView(grade: "12")
    }
}
