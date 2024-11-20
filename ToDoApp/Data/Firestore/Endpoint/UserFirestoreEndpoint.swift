//
//  UserFirestoreEndpoint.swift
//  ToDoApp
//
//  Created by Kiet Truong on 18/11/2024.
//

import Foundation

enum UserFirestoreEndpoint: FirestoreEndpoint {
    case getUser(uid: String)
    case setUser(uid: String, user: User)
    
    var path: FirestoreReference? {
        switch self {
        case .getUser(let uid), .setUser(let uid, _):
            return firestore
                .collection("users")
                .document(uid)
        }
    }

    var method: FirestoreMethod {
        switch self {
        case .getUser(_):
            return .get
        case .setUser(_, let user):
            return .post(user)
        }
    }
}
