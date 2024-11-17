//
//  ContentView.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainVM
    @State var isInitialized = false
    
    static func createInstance() -> MainView {
        let viewModel = MainVM()
        return MainView(viewModel: viewModel)
    }

    var body: some View {
        Group {
            if isInitialized {
                mainView
            } else {
                LoadingView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.isInitialized = true
            }
        }
    }

    var mainView: some View {
        Group {
            if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
                TabView {
                    BaseTabItem(.home) {
                        BaseNavigation {
                            ToDoListView.createInstance(userId: viewModel.currentUserId)
                        }
                    }

                    BaseTabItem(.profile) {
                        BaseNavigation {
                            ProfileView.createInstance()
                        }
                    }
                }
            } else {
                BaseNavigation {
                    LoginView.createInstance()
                }
            }
        }
    }
}

