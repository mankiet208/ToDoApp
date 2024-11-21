//
//  LoginView.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginVM
    
    static func createInstance() -> LoginView {
        let userRepo = UserRepositoryFirestore()
        let loginVM = LoginVM(userRepository: userRepo)
        return LoginView(viewModel: loginVM)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HeaderView(title: "TO DO",
                           subtitle: "Never miss a thing",
                           angle: 15,
                           backgroundColor: .blue)
                
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.red)
                        .padding([.leading, .trailing], 16)
                }
                
                if viewModel.state == .loading {
                    ProgressView()
                }
                
                // Form
                Form {
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    SecureTextField("Password", text: $viewModel.password)
                                        
                    TDButton(title: "Login", backgroundColor: .blue) {
                        Task {
                            await viewModel.login()
                        }
                    }
                }
                
                // Register
                VStack {
                    Text("New around here?")
                    NavigationLink(value: Route.register) {
                        Text("Create an account")
                    }
                }
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView.createInstance()
    }
}
