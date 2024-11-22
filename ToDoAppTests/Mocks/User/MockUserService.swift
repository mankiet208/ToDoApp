//
//  MockUserService.swift
//  ToDoAppTests
//
//  Created by Kiet Truong on 22/11/2024.
//

import Foundation
@testable import ToDoApp

final class MockUserService: UserService {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func getUserId() -> String? {
        return userRepository.getUserId()
    }
    
    func getUser(uid: String) async throws -> User? {
        return try await userRepository.getUser(uid: uid)
    }
    
    func setUser(uid: String, user: User) async throws {
        try await userRepository.setUser(uid: uid, user: user)
    }
    
    func createUser(email: String, password: String) async throws -> String? {
        return try await userRepository.createUser(email: email, password: password)
    }
    
    func signIn(email: String, password: String) async throws {
        try await userRepository.signIn(email: email, password: password)
    }
    
    func signOut() throws {
        try userRepository.signOut()
    }
}
