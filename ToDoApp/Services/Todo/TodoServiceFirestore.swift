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
        guard let uid = FirebaseManager.shared.getUserId() else {
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
    
    func markAsDone(uid: String, toDoId: String, isDone: Bool) async -> Result<Void, Error> {
        do {
            let documentRef = Firestore.firestore()
                .collection("users")
                .document(uid)
                .collection("todos")
                .document(toDoId)
            try await documentRef.setData(["isDone": isDone], merge: true)
            return .success(())
        } catch {
            return .failure(error)
        }
    }
    
    func addNewToDo(uid: String, todo: ToDoItem) async -> Result<Void, Error> {
        do {
            let documentRef = Firestore.firestore()
                .collection("users")
                .document(uid)
                .collection("todos")
                .document(todo.id)
            try await documentRef.setData(todo.toDict())
            return .success(())
        } catch {
            return .failure(error)
        }
    }
}
