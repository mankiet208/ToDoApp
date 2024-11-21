//
//  ToDoRepositoryImp.swift
//  ToDoApp
//
//  Created by Kiet Truong on 21/11/2024.
//

import Foundation
import FirebaseFirestore

struct ToDoRepositoryFirestore: ToDoRepository {
    
    func fetchAndListenToDos(completion: @escaping (Result<[ToDoItem], Error>) -> Void) -> ListenerRegistration? {
        return FirestoreService.fetchAndListen(
            ToDoFirestoreEndpoint.listToDo,
            orderBy: [
                QueryObject(field: "isDone", isDescending: false),
                QueryObject(field: "createDate", isDescending: true)
            ],
            completion: completion
        )
    }
    
    func fetchToDos() async throws -> [ToDoItem] {
        return try await FirestoreService.requestMany(
            ToDoFirestoreEndpoint.listToDo,
            orderBy: [
                QueryObject(field: "isDone", isDescending: false),
                QueryObject(field: "createDate", isDescending: true)
            ]
        )
    }
    
    func markAsDone(toDoId: String, isDone: Bool) async throws {
        try await FirestoreService.request(
            ToDoFirestoreEndpoint.markAsDone(toDoId: toDoId, isDone: isDone)
        )
    }
    
    func addNewToDo(todo: ToDoItem) async throws {
        try await FirestoreService.request(
            ToDoFirestoreEndpoint.addNewToDo(toDo: todo)
        )
    }
}
