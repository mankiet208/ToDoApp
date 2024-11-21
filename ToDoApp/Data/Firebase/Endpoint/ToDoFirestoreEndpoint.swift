//
//  ToDoFirestoreEndpoint.swift
//  ToDoApp
//
//  Created by Kiet Truong on 18/11/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

enum ToDoFirestoreEndpoint: FirestoreEndpoint {
    case listToDo
    case addNewToDo(toDo: ToDoItem)
    case markAsDone(toDoId: String, isDone: Bool)
    
    var path: FirestoreReference? {
        guard let uid = FirebaseAuthManager.shared.getUserId() else {
            return nil
        }

        switch self {
        case .listToDo:
            return toDoCollection(uid)
        case  .addNewToDo(let todo):
            return toDoCollection(uid).document(todo.id)
        case .markAsDone(let toDoId, _):
            return toDoCollection(uid).document(toDoId)
        }
    }

    var method: FirestoreMethod {
        switch self {
        case .listToDo:
            return .get
        case .addNewToDo(let toDo):
            return .post(toDo)
        case .markAsDone(_, let isDone):
            return .put(params: ["isDone": isDone], merge: true)
        }
    }
    
    private func toDoCollection(_ uid: String) -> CollectionReference {
        return firestore
            .collection("users")
            .document(uid)
            .collection("todos")
    }
}
