//
//  MockToDoRepository.swift
//  ToDoAppTests
//
//  Created by Kiet Truong on 21/11/2024.
//

import Foundation
@testable import ToDoApp

final class MockToDoRepository: ToDoRepository {
    
    var resultToDos: [ToDoItem] = []

    func fetchToDos(orderBy: [QueryObject]) async throws -> [ToDoItem] {
        return resultToDos
    }
    
    func markAsDone(toDoId: String, isDone: Bool) async throws {}
    
    func addNewToDo(toDo: ToDoApp.ToDoItem) async throws {}
}
