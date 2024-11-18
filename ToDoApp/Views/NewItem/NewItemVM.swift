//
//  NewItemViewVM.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewItemVM: BaseVM {
    @Published var title = ""
    @Published var dueDate = Date()
    @MainActor @Published var showAlert = false
    
    private let userRepository: UserRepository
    private let toDoRepository: ToDoRepository
    
    init(userRepository: UserRepository, toDoRepository: ToDoRepository) {
        self.userRepository = userRepository
        self.toDoRepository = toDoRepository
    }
            
    @MainActor var canSave: Bool {
        showAlert = false
        
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert = true
            return false
        }
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            showAlert = true
            return false
        }
        return true
    }
    
    func save() async {
        Task {
            guard await canSave else {
                return
            }
            
            guard let uid = userRepository.getUserId() else {
                return
            }
                       
            do {
                let toDoId = UUID().uuidString
                let newItem = ToDoItem(
                    id: toDoId,
                    title: title,
                    dueDate: dueDate.timeIntervalSince1970,
                    createDate: Date().timeIntervalSince1970,
                    isDone: false
                )
                try await toDoRepository.addNewToDo(uid: uid, todo: newItem)
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
}
