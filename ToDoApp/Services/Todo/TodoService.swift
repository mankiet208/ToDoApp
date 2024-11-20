//
//  TodoService.swift
//  ToDoApp
//
//  Created by Kiet Truong on 15/11/2024.
//

import Foundation

protocol ToDoService {
    func fetchData() async throws -> [ToDoItem]
    func markAsDone(toDoId: String, isDone: Bool) async throws
    func addNewToDo(todo: ToDoItem) async throws
}
