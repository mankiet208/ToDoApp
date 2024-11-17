//
//  TDButton.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import SwiftUI

struct TDButton: View {
    let title: String
    let backgroundColor: Color?
    let action: () -> Void
    
    init(
        title: String,
        backgroundColor: Color? = .primaryColor,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(backgroundColor)
                
                Text(title)
                    .foregroundColor(.white)
            }
        }
    }
}
