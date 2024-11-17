//
//  Codable+Extension.swift
//  ToDoList
//
//  Created by Kiet Truong on 03/07/2023.
//

import Foundation

extension Encodable {
    
    func toDict() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            return [:]
        }
        do {
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            return json ?? [:]
        } catch {
            return [:]
        }
    }
}
