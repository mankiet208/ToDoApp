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
    private let userRepository: UserRepository
    private let toDoRepository: ToDoRepository
    
    var listener: ListenerRegistration?
    
    init(userId: String, userRepository: UserRepository, toDoRepository: ToDoRepository) {
        self.userId = userId
        self.userRepository = userRepository
        self.toDoRepository = toDoRepository
    }
    
    deinit {
        if (listener != nil) {
            listener?.remove()
            listener = nil
        }
    }
    
    func fetchAndListenToDos() {
        listener = toDoRepository.fetchAndListenToDos(completion: { [weak self] result in
            switch result {
            case .success(let items):
                self?.toDoItems = items
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func markAsDone(toDoId: String) async {
        guard let index = toDoItems.firstIndex(where: {$0.id == toDoId }) else {
            return
        }
        
        do {
            let isDone = !toDoItems[index].isDone
            try await toDoRepository.markAsDone(toDoId: toDoId, isDone: isDone)
        } catch {
            print(error.localizedDescription)
        }
    }
}

