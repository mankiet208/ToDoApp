//
//  ProfileViewViewModel.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import Foundation

class ProfileVM: BaseVM {
    private let userRepo: UserRepository
    
    init(userRepo: UserRepository) {
        self.userRepo = userRepo
    }
    
    func logOut() {
        do {
            try userRepo.signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}
