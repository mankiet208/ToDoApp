//
//  StringExtension.swift
//  ToDoList
//
//  Created by Kiet Truong on 03/07/2023.
//

import Foundation

extension String: Error {}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
