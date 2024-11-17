//
//  ToDoRepository.swift
//  ToDoList
//
//  Created by Kiet Truong on 15/06/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol ToDoRepository {
//    func fetchData(completion: @escaping (Result<[ToDoItem], Error>) -> Void) -> ListenerRegistration?
    func markAsDone(uid: String, toDoId: String, isDone: Bool) async -> Result<Void, Error>
    func addNewToDo(uid: String, todo: ToDoItem) async -> Result<Void, Error>
}

struct ToDoRepositoryImp: ToDoRepository {
    
    private let service: ToDoService
    
    init(service: ToDoService) {
        self.service = service
    }
    
//    func fetchData(completion: @escaping (Result<[ToDoItem], Error>) -> Void) -> ListenerRegistration? {
//
//    }
    
    func markAsDone(uid: String, toDoId: String, isDone: Bool) async -> Result<Void, Error> {
        return await service.markAsDone(uid: uid, toDoId: toDoId, isDone: isDone)
    }
    
    func addNewToDo(uid: String, todo: ToDoItem) async -> Result<Void, Error> {
        return await service.addNewToDo(uid: uid, todo: todo)
    }
}
