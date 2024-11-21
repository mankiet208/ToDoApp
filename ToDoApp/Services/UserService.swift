//
//  UserService.swift
//  ToDoApp
//
//  Created by Kiet Truong on 21/11/2024.
//

import Foundation

protocol UserService {
    func getUserId() -> String?
    func getUser(uid: String) async throws -> User?
    func setUser(uid: String, user: User) async throws
    func createUser(email: String, password: String) async throws -> String?
    func signIn(email: String, password: String) async throws
    func signOut() throws
}

struct UserServiceImp: UserService {
    
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func getUserId() -> String? {
        return repository.getUserId()
    }
    
    func getUser(uid: String) async throws -> User? {
        return try await repository.getUser(uid: uid)
    }
    
    func setUser(uid: String, user: User) async throws {
        try await repository.setUser(uid: uid, user: user)
    }
    
    func createUser(email: String, password: String) async throws -> String? {
        return try await repository.createUser(email: email, password: password)
    }
    
    func signIn(email: String, password: String) async throws {
        try await repository.signIn(email: email, password: password)
    }
    
    func signOut() throws {
        try repository.signOut()
    }
}
