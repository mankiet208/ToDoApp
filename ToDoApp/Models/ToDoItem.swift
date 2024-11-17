//
//  ToDoItem.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import Foundation

struct ToDoItem: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createDate: TimeInterval
    var isDone: Bool
    
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
    
    init(id: String, title: String, dueDate: TimeInterval, createDate: TimeInterval, isDone: Bool) {
        self.id = id
        self.title = title
        self.dueDate = dueDate
        self.createDate = createDate
        self.isDone = isDone
    }
    
    init(data: [String: Any]) {
        id = data["id"] as? String ?? ""
        title = data["title"] as? String ?? ""
        dueDate = data["dueDate"] as? TimeInterval ?? 0
        createDate = data["createDate"] as? TimeInterval ?? 0
        isDone = data["isDone"] as? Bool ?? false
    }
}

extension ToDoItem {
    
    func toDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        let dateStr = Date(timeIntervalSinceNow: dueDate)
        return dateFormatter.string(from: dateStr)
    }
}
