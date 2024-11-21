//
//  ToDoRepository.swift
//  ToDoList
//
//  Created by Kiet Truong on 15/06/2023.
//

import Foundation
import FirebaseFirestore

protocol ToDoRepository {
    func fetchToDos(orderBy: [QueryObject]) async throws -> [ToDoItem]
    func markAsDone(toDoId: String, isDone: Bool) async throws
    func addNewToDo(toDo: ToDoItem) async throws
}

protocol ToDoListenerRepository {
    func fetchAndListenToDos(orderBy: [QueryObject],
                             completion: @escaping (Result<[ToDoItem], Error>) -> Void) -> ListenerRegistration?
}
