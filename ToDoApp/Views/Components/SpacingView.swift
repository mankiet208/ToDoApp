//
//  SwiftUIView.swift
//  SwiftUITemplate
//
//  Created by Kiet Truong on 05/07/2023.
//

import SwiftUI

struct SpacingView: View {
    let width: CGFloat?
    let height: CGFloat?
    
    init(width: CGFloat? = nil, height: CGFloat? = nil) {
        self.width = width
        self.height = height
    }
    
    var body: some View {
        Spacer()
            .frame(width: width, height: height)
    }
}
