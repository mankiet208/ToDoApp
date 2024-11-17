//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Kiet Truong on 15/11/2024.
//

import SwiftUI
import FirebaseCore

@main
struct ToDoAppApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView.createInstance()
                .accentColor(.primaryColor)
        }
    }
}
