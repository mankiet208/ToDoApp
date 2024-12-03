//
//  RegisterViewVM.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import Foundation

@MainActor
class RegisterVM: BaseVM {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    private let userRepo: UserRepository
    
    init(userRepo: UserRepository) {
        self.userRepo = userRepo
    }
    
    func register() async {
        do {
            guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
                  !password.trimmingCharacters(in: .whitespaces).isEmpty,
                  !name.trimmingCharacters(in: .whitespaces).isEmpty else {
                throw User.ValidationError.emptyField
            }
            guard email.contains("@") && email.contains(".") else {
                throw User.ValidationError.invalidEmail
            }
            
            state = .loading
            
            let uid = try await userRepo.createUser(email: email, password: password)
            
            guard let uid = uid else {
                // TODO: Handle error
                return
            }
            
            let user = User(
                id: uid,
                name: name,
                email: email,
                createdAt: Date().timeIntervalSince1970
            )
            
            try await userRepo.setUser(uid: uid, user: user)
            
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
