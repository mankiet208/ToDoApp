//
//  ProfileViewViewModel.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import Foundation

class ProfileVM: BaseVM {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func logOut() {
        do {
            try userRepository.signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}
