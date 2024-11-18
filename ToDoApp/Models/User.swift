//
//  User.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import Foundation

struct User: FirestoreIdentifiable {
    enum ValidationError: Error {
        case emptyField
        case invalidEmail
    }
    
    var id: String
    let name: String
    let email: String
    let createdAt: TimeInterval
    
    init(id: String, name: String, email: String, createdAt: TimeInterval) {
        self.id = id
        self.name = name
        self.email = email
        self.createdAt = createdAt
    }
    
    static func parse(data: [String : Any]) -> User {
        return User(
            id: data["id"] as? String ?? "",
            name: data["name"] as? String ?? "",
            email: data["email"] as? String ?? "",
            createdAt: data["createDate"] as? TimeInterval ?? 0
        )
    }
}
