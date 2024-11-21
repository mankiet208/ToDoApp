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
    func getUserId() -> String?
    func getUser(uid: String) async throws -> User?
    func setUser(uid: String, user: User) async throws
    func createUser(email: String, password: String) async throws -> String?
    func signIn(email: String, password: String) async throws
    func signOut() throws
}
