//
//  ToDoRoute.swift
//  ToDoList
//
//  Created by Kiet Truong on 20/06/2023.
//

import Foundation

enum ToDoRoute {
    case toDoList(id: String)
    case addToDo
}

extension ToDoRoute: NetworkRoute {
    
    var path: String {
        switch self {
        case .toDoList(let id):
            return "/users/\(id)/todos/"
        case .addToDo:
            return "/todos/"
        }
    }
    
    var method: NetworkMethod {
        switch self {
        case .toDoList:
            return .get
        case .addToDo:
            return .post
        }
    }
}
