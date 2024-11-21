//
//  FirestoreMethod.swift
//  ToDoApp
//
//  Created by Kiet Truong on 18/11/2024.
//

import Foundation

enum FirestoreMethod {
    case get
    case post(any FirestoreIdentifiable)
    case put(params: Dictionary<String, Any>, merge: Bool)
    case delete
}
