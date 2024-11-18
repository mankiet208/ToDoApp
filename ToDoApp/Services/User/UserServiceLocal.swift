//
//  UserServiceLocal.swift
//  ToDoApp
//
//  Created by Kiet Truong on 15/11/2024.
//

import Foundation

struct UserServiceLocal: UserService {
    func getUserId() -> String? {
        return nil
    }
    
    func getUser(uid: String) async throws -> User? {
        return nil
    }
    
    func setUser(uid: String, user: User) async throws {}
    
    func createUser(email: String, password: String) async throws -> String? {
        return nil
    }
    
    func signIn(email: String, password: String) async throws {}
    
    func signOut() throws {}
}
