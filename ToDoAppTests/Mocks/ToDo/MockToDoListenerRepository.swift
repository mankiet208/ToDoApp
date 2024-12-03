//
//  MockToDoListenerRepository.swift
//  ToDoAppTests
//
//  Created by Kiet Truong on 03/12/2024.
//

import Foundation
import FirebaseFirestore
@testable import ToDoApp

final class MockToDoListenerRepository: ToDoListenerRepository {
  
    var toDos: [ToDoItem] = []

    func fetchAndListenToDos(orderBy: [QueryObject],
                             completion: @escaping (Result<[ToDoItem], Error>) -> Void) -> ListenerRegistration? {
        return nil
    }
}
