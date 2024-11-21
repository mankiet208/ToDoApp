//
//  NewItemViewVM.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
class NewItemVM: BaseVM {
    @Published var title = ""
    @Published var dueDate = Date()
    @MainActor @Published var showAlert = false
    
    private let userService: UserService
    private let toDoService: ToDoService
    
    init(userService: UserService, toDoService: ToDoService) {
        self.userService = userService
        self.toDoService = toDoService
    }
    
    var canCreate: Bool {
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
    
    func createToDo() async -> ToDoItem? {
        guard canCreate else {
            return nil
        }
        
        do {
            let toDoId = UUID().uuidString
            let newToDo = ToDoItem(
                id: toDoId,
                title: title,
                dueDate: dueDate.timeIntervalSince1970,
                createDate: Date().timeIntervalSince1970,
                isDone: false
            )
            try await toDoService.addNewToDo(toDo: newToDo)
            
            return newToDo
        } catch {
            bannerData = BannerData(
                title: "Error",
                message: error.localizedDescription,
                type: .error
            )
            return nil
        }
    }
}
