//
//  TodoServiceFirestore.swift
//  ToDoApp
//
//  Created by Kiet Truong on 15/11/2024.
//

import Foundation
import FirebaseFirestore

struct ToDoServiceFirestore: ToDoService {
    
    func fetchData(completion: @escaping (Result<[ToDoItem], Error>) -> Void) -> ListenerRegistration? {
        guard let uid = FirebaseAuthManager.shared.getUserId() else {
            return nil
        }
        
        let collectionRef = Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("todos")
            .order(by: "isDone", descending: false)
            .order(by: "createDate", descending: true)
                        
        let listener = collectionRef.addSnapshotListener { snapshot, error in
            if error != nil {
                completion(.failure(error!))
                return
            }
            
            guard let documents = snapshot?.documents, !documents.isEmpty else {
                completion(.success([]))
                return
            }
            
            let toDoItems = documents.map { (queryDocumentSnapshot) -> ToDoItem in
                let data = queryDocumentSnapshot.data()
                return ToDoItem(data: data)
            }
            
            completion(.success(toDoItems))
        }
        
        return listener
    }
    
    func markAsDone(uid: String, toDoId: String, isDone: Bool) async throws {
        try await FirestoreService.request(
            ToDoFirestoreEndpoint.markAsDone(uid: uid, toDoId: toDoId, isDone: isDone)
        )
    }
    
    func addNewToDo(uid: String, todo: ToDoItem) async throws {
        try await FirestoreService.request(
            ToDoFirestoreEndpoint.addNewToDo(uid: uid, toDo: todo)
        )
    }
}
