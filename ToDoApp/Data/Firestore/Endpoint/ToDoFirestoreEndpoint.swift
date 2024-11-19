//
//  ToDoFirestoreEndpoint.swift
//  ToDoApp
//
//  Created by Kiet Truong on 18/11/2024.
//

import Foundation

enum ToDoFirestoreEndpoint: FirestoreEndpoint {
    case addNewToDo(uid: String, toDo: ToDoItem)
    case markAsDone(uid: String, toDoId: String, isDone: Bool)
    
    var path: FirestoreReference {
        switch self {
        case  .addNewToDo(let uid, let todo):
            return firestore
                .collection("users")
                .document(uid)
                .collection("todos")
                .document(todo.id)
        case .markAsDone(let uid, let toDoId, _):
            return firestore
                .collection("users")
                .document(uid)
                .collection("todos")
                .document(toDoId)
        }
    }

    var method: FirestoreMethod {
        switch self {
        case .addNewToDo(_, let toDo):
            return .post(toDo)
        case .markAsDone(_, _, let isDone):
            return .put(params: ["isDone": isDone], merge: true)
        }
    }
}
