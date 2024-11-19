//
//  TodoServiceLocal.swift
//  ToDoApp
//
//  Created by Kiet Truong on 15/11/2024.
//

import Foundation
import FirebaseFirestore

struct ToDoServiceLocal: ToDoService {
    
    func fetchData(completion: @escaping (Result<[ToDoItem], Error>) -> Void) -> ListenerRegistration? {
        return nil
    }
    
    func markAsDone(uid: String, toDoId: String, isDone: Bool) async throws {}
    
    func addNewToDo(uid: String, todo: ToDoItem) async throws {}
}
