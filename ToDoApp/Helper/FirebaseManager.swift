//
//  FirebaseManager.swift
//  ToDoList
//
//  Created by Kiet Truong on 20/06/2023.
//

import Foundation
import FirebaseAuth

class FirebaseManager {
    static let shared = FirebaseManager()

    func getUserId() -> String? {
       return Auth.auth().currentUser?.uid
    }
}
