//
//  UserRepository.swift
//  ToDoList
//
//  Created by Kiet Truong on 28/06/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol UserRepository {
    func getUser(uid: String) async -> Result<User?, Error>
    func setUser(uid: String, user: User) async throws
    func createUser(email: String, password: String) async throws -> String?
    func signIn(email: String, password: String) async throws
    func signOut() -> Result<Void, Error>
}

struct UserRepositoryImp: UserRepository {
    
    private let service: UserService
    
    init(service: UserService) {
        self.service = service
    }
    
    func getUser(uid: String) async -> Result<User?, Error> {
        return await service.getUser(uid: uid)
    }
    
    func setUser(uid: String, user: User) async throws {
        try await service.setUser(uid: uid, user: user)
    }
    
    func createUser(email: String, password: String) async throws -> String? {
        return try await service.createUser(email: email, password: password)
    }
    
    func signIn(email: String, password: String) async throws {
        try await service.signIn(email: email, password: password)
    }
    
    func signOut() -> Result<Void, Error> {
        return service.signOut()
    }
}
