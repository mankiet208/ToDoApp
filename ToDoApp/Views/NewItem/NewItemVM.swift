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
    
    private let toDoRepository: ToDoRepository
    
    init(toDoRepository: ToDoRepository) {
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
            guard let uid = FirebaseManager.shared.getUserId() else {
                return
            }
           
            let toDoId = UUID().uuidString
            let newItem = ToDoItem(
                id: toDoId,
                title: title,
                dueDate: dueDate.timeIntervalSince1970,
                createDate: Date().timeIntervalSince1970,
                isDone: false
            )
            let result = await toDoRepository.addNewToDo(uid: uid, todo: newItem)
          
            if case .failure(let error) = result {
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
