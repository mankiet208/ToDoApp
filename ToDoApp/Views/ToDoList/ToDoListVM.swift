//
//  ToDoListVM.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class ToDoListVM: BaseVM {
    @Published var showNewItemView = false
    @Published var toDoItems = [ToDoItem]()
    
    
    private let userId: String
    private let userRepository: UserRepository
    private let toDoRepository: ToDoRepository
    private var listener: ListenerRegistration?
    
    init(userId: String, userRepository: UserRepository, toDoRepository: ToDoRepository) {
        self.userId = userId
        self.userRepository = userRepository
        self.toDoRepository = toDoRepository
    }
    
    deinit {
        listener?.remove()
    }
    
    func markAsDone(toDoId: String) async {
        Task {
            guard let uid = userRepository.getUserId(),
                  let index = toDoItems.firstIndex(where: {$0.id == toDoId }) else {
                return
            }
            
            do {
                let isDone = !toDoItems[index].isDone
                try await toDoRepository.markAsDone(uid: uid, toDoId: toDoId, isDone: isDone)
            } catch {
                await MainActor.run {
                    bannerData = BannerData(
                        title: "Error",
                        message: error.localizedDescription,
                        type: .error
                    )
                }
            }
        }
    }
    
    func fetchData() async {
//        listener = toDoRepository.fetchData { [weak self] result in
//            switch result {
//            case .success(let items):
//                self?.toDoItems = items
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
}

