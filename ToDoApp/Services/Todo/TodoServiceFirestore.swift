//
//  TodoServiceFirestore.swift
//  ToDoApp
//
//  Created by Kiet Truong on 15/11/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ToDoServiceFirestore: ToDoService {
    
    func fetchData() async throws -> [ToDoItem] {
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

