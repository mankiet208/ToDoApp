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
    
    func getUser(uid: String) async -> Result<User?, Error> {
        do {
            let documentRef = Firestore.firestore()
                .collection("users")
                .document(uid)
            let document = try await documentRef.getDocument()
            
            guard let data = document.data() else {
                return .success(nil)
            }
            
            return .success(User(data: data))
        } catch {
            return .failure(error)
        }
    }
    
    func setUser(uid: String, user: User) async throws {
        let documentRef = Firestore.firestore().collection("users").document(uid)
        try await documentRef.setData(user.toDict())
    }
    
    func createUser(email: String, password: String) async throws -> String? {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        return result.user.uid
    }
    
    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func signOut() -> Result<Void, Error> {
        do {
            try Auth.auth().signOut()
            return .success(())
        } catch {
            return .failure(error)
        }
    }
}
