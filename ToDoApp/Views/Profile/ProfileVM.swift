//
//  ProfileViewViewModel.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import Foundation

class ProfileVM: BaseVM {
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func logOut() {
        do {
            try userService.signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}
