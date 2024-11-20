//
//  ToDoRepository.swift
//  ToDoList
//
//  Created by Kiet Truong on 15/06/2023.
//

import Foundation

protocol ToDoRepository {
    func fetchData() async throws -> [ToDoItem]
    func markAsDone(toDoId: String, isDone: Bool) async throws
    func addNewToDo(todo: ToDoItem) async throws
}

struct ToDoRepositoryImp: ToDoRepository {
    
    private let service: ToDoService
    
    init(service: ToDoService) {
        self.service = service
    }
    
    func fetchData() async throws -> [ToDoItem] {
        return try await service.fetchData()
    }
    
    func markAsDone(toDoId: String, isDone: Bool) async throws {
        return try await service.markAsDone(toDoId: toDoId, isDone: isDone)
    }
    
    func addNewToDo(todo: ToDoItem) async throws {
        return try await service.addNewToDo(todo: todo)
    }
}
