//
//  RegisterView.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: RegisterVM
    
    static func createInstance() -> RegisterView {
        let registerVM = RegisterVM(userRepo: UserRepositoryFirestore())
        return RegisterView(viewModel: registerVM)
    }
    
    var body: some View {
        VStack {
            HeaderView(title: "REGISTER",
                       subtitle: "Start organizing todos",
                       angle: -15,
                       backgroundColor: .orange)
            
            Form {
                TextField("Full Name", text: $viewModel.name)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                TextField("Email Address", text: $viewModel.email)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(DefaultTextFieldStyle())
                                    
                TDButton(title: "Register", backgroundColor: .green) {
                    Task {
                        await viewModel.register()
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView.createInstance()
    }
}
