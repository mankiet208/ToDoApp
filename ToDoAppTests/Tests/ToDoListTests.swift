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
        mockToDoRepository.toDos = Constants.toDos
        
        let viewModel = ToDoListVM(
            userId: "USER_ID",
            userRepo: MockUserRepository(),
            toDoRepo: mockToDoRepository,
            toDoListenerRepo: MockToDoListenerRepository()
        )
        
        // When
        await viewModel.fetchToDos()
        
        // Then
        XCTAssertEqual(viewModel.toDoItems.count, 3)
    }
    
    @MainActor
    func test_markAsDone_success() async throws {
        // Given
        let mockToDoRepository = MockToDoRepository()
        mockToDoRepository.toDos = Constants.toDos
        
        let viewModel = ToDoListVM(
            userId: "USER_ID",
            userRepo: MockUserRepository(),
            toDoRepo: mockToDoRepository,
            toDoListenerRepo: MockToDoListenerRepository()
        )
        
        // When
        await viewModel.fetchToDos()
        await viewModel.markAsDone(toDoId: "todo_1")
        await viewModel.fetchToDos()
        
        // Then
        XCTAssertEqual(viewModel.toDoItems[0].isDone, true)
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
                isDone: true
            ),
            ToDoItem(
                id: "todo_3",
                title: "Task 3",
                dueDate: Date().timeIntervalSince1970,
                createDate: Date().timeIntervalSince1970,
                isDone: true
            )
        ]
    }
}
