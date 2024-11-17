//
//  Network.swift
//  ToDoList
//
//  Created by Kiet Truong on 20/06/2023.
//

import Foundation

protocol Network {
    var decoder: JSONDecoder { get set }
    var environment: NetworkEnvironment { get set }
}

extension Network {
    
    func fetch<T: Decodable>(route: NetworkRoute) async throws -> T? {
        let request: URLRequest = route.create(for: environment)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }
    
    func fetchList<T: Decodable>(route: NetworkRoute) async throws -> [T] {
        let request: URLRequest = route.create(for: environment)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let result = try JSONDecoder().decode([T].self, from: data)
        return result
    }
}
