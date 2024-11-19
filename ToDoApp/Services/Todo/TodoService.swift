//
//  TodoService.swift
//  ToDoApp
//
//  Created by Kiet Truong on 15/11/2024.
//

import Foundation
import FirebaseFirestore

protocol ToDoService {
    func fetchData(completion: @escaping (Result<[ToDoItem], Error>) -> Void) -> ListenerRegistration?
    func markAsDone(uid: String, toDoId: String, isDone: Bool) async throws
    func addNewToDo(uid: String, todo: ToDoItem) async throws
}
