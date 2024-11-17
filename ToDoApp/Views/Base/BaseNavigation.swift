//
//  BaseNavigation.swift
//  ToDoList
//
//  Created by Kiet Truong on 29/06/2023.
//

import SwiftUI

enum Route: Hashable {
    case register
    case toDoDetail(toDo: ToDoItem)
}

struct BaseNavigation<Content: View>: View {
    @State private var path: [Route] = []
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            content.navigationDestination(for: Route.self) { route in
                switch route {
                case .register:
                    RegisterView.createInstance()
                case .toDoDetail(let item):
                    ToDoDetailView(item)
                }
            }
        }
    }
}
