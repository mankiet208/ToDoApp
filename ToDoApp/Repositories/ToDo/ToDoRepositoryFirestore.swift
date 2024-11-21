//
//  ToDoRepositoryImp.swift
//  ToDoApp
//
//  Created by Kiet Truong on 21/11/2024.
//

import Foundation
import FirebaseFirestore

struct ToDoRepositoryFirestore: ToDoRepository {
    
    func fetchToDos(orderBy: [QueryObject]) async throws -> [ToDoItem] {
        return try await FirestoreService.requestMany(
            ToDoFirestoreEndpoint.listToDo,
            orderBy: orderBy
        )
    }
    
    func markAsDone(toDoId: String, isDone: Bool) async throws {
        try await FirestoreService.request(
            ToDoFirestoreEndpoint.markAsDone(toDoId: toDoId, isDone: isDone)
        )
    }
    
    func addNewToDo(toDo: ToDoItem) async throws {
        try await FirestoreService.request(
            ToDoFirestoreEndpoint.addNewToDo(toDo: toDo)
        )
    }
}

struct ToDoListenerRepositoryFirestore: ToDoListenerRepository {
    
    func fetchAndListenToDos(orderBy: [QueryObject],
                             completion: @escaping (Result<[ToDoItem], Error>) -> Void) -> ListenerRegistration? {
        return FirestoreService.fetchAndListen(
            ToDoFirestoreEndpoint.listToDo,
            orderBy: orderBy,
            completion: completion
        )
    }
}
