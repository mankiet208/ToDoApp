//
//  NewItemView.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import SwiftUI

struct NewItemView: View {
    @ObservedObject var viewModel: NewItemVM
    @Binding var isPresented: Bool
        
    static func createInstance(isPresented: Binding<Bool>) -> NewItemView {
        let userService = UserServiceImp(repository: UserRepositoryFirestore())
        let toDoService = ToDoServiceImp(
            toDoRepository: ToDoRepositoryFirestore(),
            toDoListenRepository: ToDoListenerRepositoryFirestore()
        )
        let newItemVM = NewItemVM(userService: userService, toDoService: toDoService)
        return NewItemView(viewModel: newItemVM, isPresented: isPresented)
    }
    
    var body: some View {
        VStack {
            HStack() {
                Text("Add new todo")
                    .font(.system(size: 32))
                    .bold()
                
                Spacer()
                
                Button {
                    isPresented = false
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }
            .padding()
          
            Form {
                // Title
                TextField("Title", text: $viewModel.title)
                
                // Due Date
                DatePicker("Due Date", selection: $viewModel.dueDate, in: Date.now...)
                    .datePickerStyle(.graphical)
                
                // Button
                TDButton(title: "Create", backgroundColor: .blue) {
                    if viewModel.canCreate {
                        Task {
                            _ = await viewModel.createToDo()
                            isPresented = false
                        }
                    } else {
                        viewModel.showAlert = true
                    }
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Please fill all fields")
                )
            }
        }
    }
}

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView.createInstance(isPresented: .constant(true))
    }
}
