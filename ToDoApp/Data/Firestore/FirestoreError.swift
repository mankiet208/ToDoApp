//
//  FirestoreError.swift
//  ToDoApp
//
//  Created by Kiet Truong on 18/11/2024.
//

import Foundation

enum FirestoreServiceError: Error {
    case documentNotFound
    case collectionNotFound
    case invalidPath
    case invalidRequest
    case parseError
    case operationNotSupported
}
