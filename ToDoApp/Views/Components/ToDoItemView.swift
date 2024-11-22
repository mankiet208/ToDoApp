//
//  ToDoItemView.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import SwiftUI

struct ToDoItemView: View {
    @Binding var toDoItem: ToDoItem
    
    let onMarkAsDone: (() -> Void)?
    let onRemoveToDo: ((String) -> Void)?
    
    var body: some View {
        let fontWeight: Font.Weight = toDoItem.isDone ? .regular : .bold
        let foregroundColor: Color = toDoItem.isDone ? .gray : .black
        let isDoneText = toDoItem.isDone ? "Undone" : "Done"
        
        HStack {
            VStack(alignment: .leading) {
                Text(toDoItem.title)
                    .font(.title3)
                    .fontWeight(fontWeight)
                    .foregroundColor(foregroundColor)
                
                Text(toDoItem.toDateString())
                    .font(.subheadline)
            }
        }
        .swipeActions(edge: .leading) {
            Button(isDoneText) {
                onMarkAsDone?()
            }
            .tint(.blue)
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                onRemoveToDo?(toDoItem.id)
            } label: {
                Label("Delete", systemImage: "trash")
            }

        }
    }
}

struct ToDoItemView_Previews: PreviewProvider {
    @State static var toDoItem = ToDoItem(
        id: "",
        title: "Title",
        dueDate: 3600,
        createDate: 3600,
        isDone: false
    )
    
    static var previews: some View {
        ToDoItemView(toDoItem: $toDoItem, onMarkAsDone: nil, onRemoveToDo: nil)
    }
}
