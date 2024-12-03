//
//  LoginViewVM.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import Foundation

@MainActor
class LoginVM: BaseVM {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""

    private let userRepo: UserRepository
    
    init(userRepo: UserRepository) {
        self.userRepo = userRepo
    }
    
    func login() async {
        do {
            guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
                  !password.trimmingCharacters(in: .whitespaces).isEmpty else {
                throw User.ValidationError.emptyField
            }
            guard email.contains("@") && email.contains(".") else {
                throw User.ValidationError.invalidEmail
            }
            
            state = .loading
            
            try await userRepo.signIn(email: email, password: password)

            state = .idle
            
        } catch User.ValidationError.emptyField {
            errorMessage = "Please fill in all field"
        } catch User.ValidationError.invalidEmail {
            errorMessage = "Please enter valid email"
        } catch {
            errorMessage = error.localizedDescription
            state = .idle
        }
    }
}
