//
//  FirebaseManager.swift
//  ToDoList
//
//  Created by Kiet Truong on 20/06/2023.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager {
    static let shared = FirebaseAuthManager()
    
    var auth: Auth {
        Auth.auth()
    }
    
    func getUserId() -> String? {
        return auth.currentUser?.uid
    }
    
    func createUser(email: String, password: String) async throws -> String? {
        let result = try await auth.createUser(withEmail: email, password: password)
        return result.user.uid
    }
    
    func signIn(email: String, password: String) async throws {
        try await auth.signIn(withEmail: email, password: password)
    }
    
    func signOut() throws {
        try auth.signOut()
    }
}
