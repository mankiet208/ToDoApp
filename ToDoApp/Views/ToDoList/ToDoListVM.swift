//
//  ToDoListVM.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import SwiftUI
import FirebaseFirestore

@MainActor
class ToDoListVM: BaseVM {
    @Published var showNewItemView = false
    @Published var toDoItems = [ToDoItem]()
    
    private let userId: String
    private let userService: UserService
    private let toDoService: ToDoService
    
    private var listener: ListenerRegistration?
    
    init(userId: String, userService: UserService, toDoService: ToDoService) {
        self.userId = userId
        self.userService = userService
        self.toDoService = toDoService
    }
    
    deinit {
        if (listener != nil) {
            listener?.remove()
            listener = nil
        }
    }
    
    func fetchAndListenToDos() {
        listener = toDoService.fetchAndListenToDos(completion: { [weak self] result in
            switch result {
            case .success(let items):
                self?.toDoItems = items
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func fetchToDos() async {
        do {
            let toDos = try await toDoService.fetchToDos()
            self.toDoItems = toDos
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func markAsDone(toDoId: String) async {
        guard let index = toDoItems.firstIndex(where: {$0.id == toDoId }) else {
            return
        }
        
        do {
            let isDone = !toDoItems[index].isDone
            try await toDoService.markAsDone(toDoId: toDoId, isDone: isDone)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteToDo(toDoId: String) async {
        do {
            try await toDoService.deleteToDo(toDoId: toDoId)
        } catch {
            print(error.localizedDescription)
        }
    }
}

