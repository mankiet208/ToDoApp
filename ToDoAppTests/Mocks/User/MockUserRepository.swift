//
//  MockUserRepository.swift
//  ToDoAppTests
//
//  Created by Kiet Truong on 21/11/2024.
//

import Foundation
@testable import ToDoApp

final class MockUserRepository: UserRepository {
    
    func getUserId() -> String? {
        return "USER_ID"
    }
    
    func getUser(uid: String) async throws -> User? {
        return nil
    }
    
    func setUser(uid: String, user: User) async throws {}
    
    func createUser(email: String, password: String) async throws -> String? {
        return "USER_ID"
    }
    
    func signIn(email: String, password: String) async throws {}
    
    func signOut() throws {}
}
