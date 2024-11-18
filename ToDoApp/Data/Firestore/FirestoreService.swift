//
//  FirestoreRequest.swift
//  ToDoApp
//
//  Created by Kiet Truong on 18/11/2024.
//

import Foundation
import FirebaseFirestore

protocol FirestoreServiceProtocol {
    static func request(_ endpoint: FirestoreEndpoint) async throws -> Void
    static func requestOne<T>(_ endpoint: FirestoreEndpoint) async throws -> T where T: FirestoreIdentifiable
    static func requestMany<T>(_ endpoint: FirestoreEndpoint) async throws -> [T] where T: FirestoreIdentifiable
}

final class FirestoreService: FirestoreServiceProtocol {

    private init() {}
    
    static func request(_ endpoint: FirestoreEndpoint) async throws -> Void {
        guard let ref = endpoint.path as? DocumentReference else {
            throw FirestoreServiceError.documentNotFound
        }
        switch endpoint.method {
        case .get:
            throw FirestoreServiceError.invalidRequest
        case .post(var model):
            model.id = ref.documentID
            try await ref.setData(model.toDictionary())
        case .put(let params, let merge):
            try await ref.setData(params, merge: merge)
        case .delete:
            try await ref.delete()
        }
    }

    static func requestOne<T>(_ endpoint: FirestoreEndpoint) async throws -> T where T: FirestoreIdentifiable {
        guard let ref = endpoint.path as? DocumentReference else {
            throw FirestoreServiceError.documentNotFound
        }
        switch endpoint.method {
        case .get:
            guard let documentSnapshot = try? await ref.getDocument() else {
                throw FirestoreServiceError.invalidPath
            }

            guard let documentData = documentSnapshot.data() else {
                throw FirestoreServiceError.parseError
            }

            let response = T.parse(data: documentData)
            return response
        default:
            throw FirestoreServiceError.invalidRequest
        }
    }

    static func requestMany<T>(_ endpoint: FirestoreEndpoint) async throws -> [T] where T: FirestoreIdentifiable {
        guard let ref = endpoint.path as? CollectionReference else {
            throw FirestoreServiceError.collectionNotFound
        }
        switch endpoint.method {
        case .get:
            let querySnapshot = try await ref.getDocuments()
            var response: [T] = []
            for document in querySnapshot.documents {
                document.data()
                let data = T.parse(data: document.data())
                response.append(data)
            }
            return response
        case .post, .put, .delete:
            throw FirestoreServiceError.operationNotSupported
        }
    }
}
