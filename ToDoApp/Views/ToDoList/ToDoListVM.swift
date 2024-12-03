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
    private let userRepo: UserRepository
    private let toDoRepo: ToDoRepository
    private let toDoListenerRepo: ToDoListenerRepository
    
    private var listener: ListenerRegistration?
    
    init(
        userId: String,
        userRepo: UserRepository,
        toDoRepo: ToDoRepository,
        toDoListenerRepo: ToDoListenerRepository
    ) {
        self.userId = userId
        self.userRepo = userRepo
        self.toDoRepo = toDoRepo
        self.toDoListenerRepo = toDoListenerRepo
    }
    
    deinit {
        if (listener != nil) {
            listener?.remove()
            listener = nil
        }
    }
    
    func fetchAndListenToDos() {
        listener = toDoListenerRepo.fetchAndListenToDos(
            orderBy: [
                QueryObject(field: "isDone", isDescending: false),
                QueryObject(field: "createDate", isDescending: true)
            ]
        ) { [weak self] result in
            switch result {
            case .success(let items):
                self?.toDoItems = items
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchToDos() async {
        do {
            let toDos = try await toDoRepo.fetchToDos(
                orderBy: [
                    QueryObject(field: "isDone", isDescending: false),
                    QueryObject(field: "createDate", isDescending: true)
                ]
            )
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
            try await toDoRepo.markAsDone(toDoId: toDoId, isDone: isDone)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteToDo(toDoId: String) async {
        do {
            try await toDoRepo.deleteToDo(toDoId: toDoId)
        } catch {
            print(error.localizedDescription)
        }
    }
}

