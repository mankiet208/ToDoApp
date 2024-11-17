//
//  ToDoItemView.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import SwiftUI

struct ToDoItemView: View {
    @Binding var toDoItem: ToDoItem
    
    let onTrailingSwipe: (() -> Void)?
    
    var body: some View {
        let fontWeight: Font.Weight = toDoItem.isDone ? .regular : .bold
        let foregroundColor: Color = toDoItem.isDone ? .gray : .black
        let trailingSwipeText = toDoItem.isDone ? "Unread" : "Read"
        
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
        .swipeActions {
            Button(trailingSwipeText) {
                onTrailingSwipe?()
            }
            .tint(.blue)
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
        ToDoItemView(toDoItem: $toDoItem, onTrailingSwipe: nil)
    }
}
