//
//  DetailCardView.swift
//  MovieDB
//
//  Created by Kyo on 3/7/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import SwiftUI

struct DetailCard: View {
    private let viewModel: DetailCardVM
    
    
    init(viewModel: DetailCardVM) {
        self.viewModel = viewModel
        
    }
    
    var body: some View {
        Text("\(self.viewModel.audience ?? "N/A")")
    }
}
