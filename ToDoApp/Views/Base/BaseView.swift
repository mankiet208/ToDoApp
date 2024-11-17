//
//  BaseView.swift
//  ToDoList
//
//  Created by Kiet Truong on 28/06/2023.
//

import SwiftUI

struct BaseView<Content: View>: View {
    let title: String
    let content: Content
        
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        content.navigationTitle(title)
    }
}
