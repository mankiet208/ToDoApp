//
//  TabItem.swift
//  ToDoList
//
//  Created by Kiet Truong on 30/06/2023.
//

import SwiftUI

enum TabItem: Hashable {
    case home, profile
}

extension TabItem {
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .profile:
            return "Profile"
        }
    }
    
    var image: String {
        switch self {
        case .home:
            return "house"
        case .profile:
            return "person.circle"
        }
    }
}

struct BaseTabItem<Content: View>: View {
    let tab: TabItem
    let content: Content
    
    init(_ tab: TabItem,
         @ViewBuilder content: () -> Content) {
        self.tab = tab
        self.content = content()
    }
    
    var body: some View {
        content
            .tabItem {
                Label(tab.title, systemImage: tab.image)
                    .foregroundColor(.primaryColor)
            }
            .tag(tab)
    }
}
