//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Kiet Truong on 15/11/2024.
//

import SwiftUI

@main
struct ToDoAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            MainView.createInstance()
                .accentColor(.primaryColor)
        }
    }
}
