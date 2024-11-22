//
//  ToDoService.swift
//  ToDoApp
//
//  Created by Kiet Truong on 21/11/2024.
//

import Foundation
import FirebaseFirestore

protocol ToDoService {
    func fetchAndListenToDos(completion: @escaping (Result<[ToDoItem], Error>) -> Void) -> ListenerRegistration?
    func fetchToDos() async throws -> [ToDoItem]
    func markAsDone(toDoId: String, isDone: Bool) async throws
    func addNewToDo(toDo: ToDoItem) async throws
    func deleteToDo(toDoId: String) async throws
}

struct ToDoServiceImp: ToDoService {
    
    private let toDoRepository: ToDoRepository
    private let toDoListenRepository: ToDoListenerRepository
    
    init(
        toDoRepository: ToDoRepository,
        toDoListenRepository: ToDoListenerRepository
    ) {
        self.toDoRepository = toDoRepository
        self.toDoListenRepository = toDoListenRepository
    }
    
    func fetchAndListenToDos(completion: @escaping (Result<[ToDoItem], Error>) -> Void) -> ListenerRegistration? {
        return toDoListenRepository.fetchAndListenToDos(
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
    
    func deleteToDo(toDoId: String) async throws {
        try await toDoRepository.deleteToDo(toDoId: toDoId)
    }
}
