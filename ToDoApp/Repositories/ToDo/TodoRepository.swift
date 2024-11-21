//
//  ToDoRepository.swift
//  ToDoList
//
//  Created by Kiet Truong on 15/06/2023.
//

import Foundation
import FirebaseFirestore

protocol ToDoRepository {
    func fetchAndListenToDos(completion: @escaping (Result<[ToDoItem], Error>) -> Void) -> ListenerRegistration?
    func fetchToDos() async throws -> [ToDoItem]
    func markAsDone(toDoId: String, isDone: Bool) async throws
    func addNewToDo(todo: ToDoItem) async throws
}
