//
//  TodoServiceLocal.swift
//  ToDoApp
//
//  Created by Kiet Truong on 15/11/2024.
//

import Foundation
import FirebaseFirestore

struct ToDoServiceLocal: ToDoService {
    
    func fetchData() -> [ToDoItem] {
        return []
    }
    
    func markAsDone(toDoId: String, isDone: Bool) async throws {}
    
    func addNewToDo(todo: ToDoItem) async throws {}
}
