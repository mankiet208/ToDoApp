//
//  FirestoreEndpoint.swift
//  ToDoApp
//
//  Created by Kiet Truong on 18/11/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol FirestoreEndpoint {
    var path: FirestoreReference { get }
    var method: FirestoreMethod { get }
}

extension FirestoreEndpoint {
    var firestore: Firestore {
        Firestore.firestore()
    }
}
