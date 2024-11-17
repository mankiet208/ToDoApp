//
//  AppLabel.swift
//  SwiftUITemplate
//
//  Created by Kiet Truong on 06/07/2023.
//

import SwiftUI

struct AppLabel: View {
    let text: String
    let font: Font?
    let fontSize: CGFloat
    let fontWeight: FontWeight
    let foregroundColor: Color?
    
    init(
        text: String,
        font: Font?,
        fontSize: CGFloat = 14,
        fontWeight: FontWeight = .regular,
        foregroundColor: Color? = .textColor
    ) {
        self.text = text
        self.font = font
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.foregroundColor = foregroundColor
    }
    
    var body: some View {
        if let font = font {
            Text(text)
                .font(font)
                .foregroundColor(foregroundColor)
        } else {
            Text(text)
                .font(.system(size: fontSize))
                .foregroundColor(foregroundColor)
        }
       
    }
}
