//
//  TodoServiceLocal.swift
//  ToDoApp
//
//  Created by Kiet Truong on 15/11/2024.
//

import Foundation

struct ToDoServiceLocal: ToDoService {
    
    func markAsDone(uid: String, toDoId: String, isDone: Bool) async -> Result<Void, Error> {
        return .success(())
    }
    
    func addNewToDo(uid: String, todo: ToDoItem) async -> Result<Void, Error> {
        return .success(())
    }
}
