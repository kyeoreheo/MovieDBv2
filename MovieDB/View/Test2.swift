//
//  Test2.swift
//  MovieDB
//
//  Created by Kyo on 3/7/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI

struct Test2: View {
    
    @State var flag = false
    let text = ["Hello World", """
    So even if the text is suepr long, text height exsdlkfjsdlkfpend to boexsdlkfjsdlkfpend to boexsdlkfjsdlkfpend to boexsdlkfjsdlkfpend to boexsdlkfjsdlkfpend to boexsdlkfjsdlkfpend to boexsdlkfjsdlkfpend to boexsdlkfjsdlkfpend to boexsdlkfjsdlkfpend to boexsdlkfjsdlkfpend to boexsdlkfjsdlkfpend to bottom. not top and bottom
    """]
        var body: some View {
            GeometryReader { proxy in
                ZStack {
                    Rectangle()
                        .fill(Color.green)
                        .frame(height:200)
                        .offset(y: 100)

                    VStack{
                        Color.clear.frame(height: proxy.size.height / 3)
                        Image(systemName: "star")
                        .resizable()
                            .frame(width: 50, height: 50).onTapGesture {
                                self.flag.toggle()
                        }
                        Text(self.text[self.flag ? 0 : 1])
                            .font(.system(size: 30))
                            .padding()
                        Spacer()
                        //Color.yellow
                    }
                }
            }
        }
}

struct Test2_Previews: PreviewProvider {
    static var previews: some View {
        Test2()
    }
}
