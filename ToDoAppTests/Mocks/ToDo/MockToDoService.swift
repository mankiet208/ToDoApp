//
//  MockToDoService.swift
//  ToDoAppTests
//
//  Created by Kiet Truong on 22/11/2024.
//

import Foundation
import FirebaseFirestore
@testable import ToDoApp

final class MockToDoService: ToDoService {
    
    private let toDoRepository: ToDoRepository
    private let toDoListenerRepository: ToDoListenerRepository
    
    init(toDoRepository: ToDoRepository, toDoListenerRepository: ToDoListenerRepository) {
        self.toDoRepository = toDoRepository
        self.toDoListenerRepository = toDoListenerRepository
    }
    
    func fetchAndListenToDos(completion: @escaping (Result<[ToDoApp.ToDoItem], Error>) -> Void) -> ListenerRegistration? {
        return toDoListenerRepository.fetchAndListenToDos(
            orderBy: [
                QueryObject(field: "isDone", isDescending: false),
                QueryObject(field: "createDate", isDescending: true)
            ],
            completion: completion
        )
    }
    
    func fetchToDos() async throws -> [ToDoItem] {
        return try await toDoRepository.fetchToDos(
            orderBy: [
            QueryObject(field: "isDone", isDescending: false),
            QueryObject(field: "createDate", isDescending: true)
            ]
        )
    }
    
    func markAsDone(toDoId: String, isDone: Bool) async throws {
        try await toDoRepository.markAsDone(toDoId: toDoId, isDone: isDone)
    }
    
    func addNewToDo(toDo: ToDoItem) async throws {
        try await toDoRepository.addNewToDo(toDo: toDo)
    }
}
