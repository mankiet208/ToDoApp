//
//  ToDoListTests.swift
//  ToDoAppTests
//
//  Created by Kiet Truong on 21/11/2024.
//

import XCTest
@testable import ToDoApp

final class ToDoListTests: XCTestCase {
    
    @MainActor
    func test_fetchToDos_success() async throws {
        // Given
        let mockToDoRepository = MockToDoRepository()
        mockToDoRepository.resultToDos = Constants.toDos
        
        let userService = UserServiceImp(repository: UserRepositoryFirestore())
        let toDoService = ToDoServiceImp(toDoRepository: mockToDoRepository, toDoListenRepository: ToDoListenerRepositoryFirestore())
        let viewModel = ToDoListVM(userId: "USER_ID", userService: userService, toDoService: toDoService)
        
        // When
        await viewModel.fetchToDos()
        
        // Then
        XCTAssertEqual(viewModel.toDoItems.count, 3)
    }
}

extension ToDoListTests {
    enum Constants {
        static let toDos: [ToDoItem] = [
            ToDoItem(
                id: "todo_1",
                title: "Task 1",
                dueDate: Date().timeIntervalSince1970,
                createDate: Date().timeIntervalSince1970,
                isDone: false
            ),
            ToDoItem(
                id: "todo_2",
                title: "Task 2",
                dueDate: Date().timeIntervalSince1970,
                createDate: Date().timeIntervalSince1970,
                isDone: false
            ),
            ToDoItem(
                id: "todo_3",
                title: "Task 3",
                dueDate: Date().timeIntervalSince1970,
                createDate: Date().timeIntervalSince1970,
                isDone: false
            )
        ]
    }
}
