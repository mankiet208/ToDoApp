//
//  UserServiceFirestore.swift
//  ToDoApp
//
//  Created by Kiet Truong on 15/11/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct UserServiceFirestore: UserService {
    
    func getUserId() -> String? {
        return FirebaseAuthManager.shared.getUserId()
    }
    
    func getUser(uid: String) async throws -> User? {        
        return try await FirestoreService.requestOne(
            UserFirestoreEndpoint.getUser(uid: uid)
        )
    }
    
    func setUser(uid: String, user: User) async throws {
        try await FirestoreService.request(
            UserFirestoreEndpoint.setUser(uid: uid, user: user)
        )
    }
    
    func createUser(email: String, password: String) async throws -> String? {
        return try await FirebaseAuthManager.shared.createUser(email: email, password: password)
    }
    
    func signIn(email: String, password: String) async throws {
        try await FirebaseAuthManager.shared.signIn(email: email, password: password)
    }
    
    func signOut() throws {
        try FirebaseAuthManager.shared.signOut()
    }
}
