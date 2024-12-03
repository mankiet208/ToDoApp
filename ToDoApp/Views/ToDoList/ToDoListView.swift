//
//  ToDoListView.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import SwiftUI

struct ToDoListView: View {
    @ObservedObject var viewModel: ToDoListVM

    static func createInstance(userId: String) -> ToDoListView {
        let toDoListVM = ToDoListVM(
            userId: userId,
            userRepo: UserRepositoryFirestore(),
            toDoRepo: ToDoRepositoryFirestore(),
            toDoListenerRepo: ToDoListenerRepositoryFirestore()
        )
        return ToDoListView(viewModel: toDoListVM)
    }

    var body: some View {
        BaseView(title: "Home") {
            VStack {
                List($viewModel.toDoItems, id: \.id) { $item in
                    NavigationLink(value: Route.toDoDetail(toDo: item)) {
                        ToDoItemView(toDoItem: $item) {
                            Task {
                                await viewModel.markAsDone(toDoId: item.id)
                            }
                        } onRemoveToDo: { toDoId in
                            Task {
                                await viewModel.deleteToDo(toDoId: toDoId)
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .toolbar {
                Button {
                    viewModel.showNewItemView.toggle()
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.primaryColor)
                }
            }
            .sheet(isPresented: $viewModel.showNewItemView) {
                NewItemView.createInstance(isPresented: $viewModel.showNewItemView)
            }
            .banner(data: $viewModel.bannerData)
            .task {
                viewModel.fetchAndListenToDos()
            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView.createInstance(userId: "")
    }
}
