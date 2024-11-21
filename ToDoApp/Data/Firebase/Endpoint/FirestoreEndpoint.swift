//
//  FirestoreEndpoint.swift
//  ToDoApp
//
//  Created by Kiet Truong on 18/11/2024.
//

import Foundation
import FirebaseFirestore

protocol FirestoreEndpoint {
    var path: FirestoreReference? { get }
    var method: FirestoreMethod { get }
    var firestore: Firestore { get }
}

extension FirestoreEndpoint {
    var firestore: Firestore {
        Firestore.firestore()
    }
}
