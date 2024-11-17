//
//  FontExtension.swift
//  SwiftUITemplate
//
//  Created by Kiet Truong on 06/07/2023.
//

import SwiftUI

enum FontWeight {
    case light, regular, medium, bold
}

extension FontWeight {
    
    var name: String {
        switch self {
        case .light:
            return "Roboto-Light"
        case .regular:
            return "Roboto-Regular"
        case .medium:
            return "Roboto-Medium"
        case .bold:
            return "Roboto-Bold"
        }
    }
}

extension Font {
    static let body = Font.custom(FontWeight.regular.name, size: 17)
}
