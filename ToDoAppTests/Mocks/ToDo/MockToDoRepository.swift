//
//  MockToDoRepository.swift
//  ToDoAppTests
//
//  Created by Kiet Truong on 21/11/2024.
//

import Foundation
@testable import ToDoApp

final class MockToDoRepository: ToDoRepository {
   
    var toDos: [ToDoItem] = []

    func fetchToDos(orderBy: [QueryObject]) async throws -> [ToDoItem] {
        return toDos
    }
    
    func markAsDone(toDoId: String, isDone: Bool) async throws {
        if let row = toDos.firstIndex(where: {$0.id == toDoId}) {
            toDos[row].isDone = isDone
        }
    }
    
    func addNewToDo(toDo: ToDoItem) async throws {
        toDos.append(toDo)
    }
    
    func deleteToDo(toDoId: String) async throws {
        toDos.removeAll(where: { $0.id == toDoId })
    }
}
