//
//  MockUserRepository.swift
//  ToDoAppTests
//
//  Created by Kiet Truong on 21/11/2024.
//

import Foundation
@testable import ToDoApp

final class MockUserRepository: UserRepository {
    
    var user: User? = nil
    
    func getUserId() -> String? {
        return user?.id
    }
    
    func getUser(uid: String) async throws -> User? {
        return user
    }
    
    func setUser(uid: String, user: User) async throws {}
    
    func createUser(email: String, password: String) async throws -> String? {
        return user?.id
    }
    
    func signIn(email: String, password: String) async throws {}
    
    func signOut() throws {}
}
