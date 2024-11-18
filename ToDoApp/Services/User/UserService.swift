//
//  UserService.swift
//  ToDoApp
//
//  Created by Kiet Truong on 15/11/2024.
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
