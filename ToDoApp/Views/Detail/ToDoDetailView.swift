//
//  ToDoDetailView.swift
//  ToDoList
//
//  Created by Kiet Truong on 29/06/2023.
//

import SwiftUI

struct ToDoDetailView: View {
    let toDoItem: ToDoItem
    
    init(_ toDoItem: ToDoItem) {
        self.toDoItem = toDoItem
    }
    
    var body: some View {
        BaseView(title: "Detail") {
            Text(toDoItem.title)
        }
    }
}

struct ToDoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoDetailView(
            ToDoItem(
                id: "111",
                title: "Title",
                dueDate: Date().timeIntervalSinceNow,
                createDate: Date().timeIntervalSinceNow,
                isDone: false
            )
        )
    }
}
