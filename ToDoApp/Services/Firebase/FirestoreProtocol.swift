//
//  FirestoreProtocol.swift
//  ToDoApp
//
//  Created by Kiet Truong on 18/11/2024.
//

import Foundation
import FirebaseFirestore

protocol FirestoreReference {}
extension DocumentReference: FirestoreReference {}
extension CollectionReference: FirestoreReference {}

protocol FirestoreIdentifiable: Hashable, Codable, Identifiable {
    var id: String { get set }
    static func parse(data: [String: Any]) -> Self
}
