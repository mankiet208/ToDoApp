//
//  AddNewToDoTest.swift
//  ToDoAppTests
//
//  Created by Kiet Truong on 03/12/2024.
//

import XCTest
@testable import ToDoApp

final class AddNewToDoTests: XCTestCase {
    
    @MainActor
    func test_createToDo_success() async throws {
        // Given
        let mockToDoRepository = MockToDoRepository()
        
        let viewModel = NewItemVM(
            userRepo: MockUserRepository(),
            toDoRepo: mockToDoRepository
        )
        
        
        // When
        viewModel.title = "Task 1"
        let newToDo = await viewModel.createToDo()
        
        // Then
        XCTAssertEqual(newToDo?.title, "Task 1")
        XCTAssertEqual(mockToDoRepository.toDos.first?.title, "Task 1")
    }
}
