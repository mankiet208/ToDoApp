//
//  DIContainer.swift
//  ToDoList
//
//  Created by Kiet Truong on 28/06/2023.
//

import Foundation

class DIContainer {
    
    private static var factories: [String: () -> Any] = [:]
    private static var cache: [String: Any] = [:]
    
    static func register<DI>(type: DI.Type, _ factory: @autoclosure @escaping () -> DI) {
        factories[String(describing: type.self)] = factory
    }
    
    static func resolve<DI>(_ resolveType: DIType = .automatic, _ type: DI.Type) -> DI? {
        let diName = String(describing: type.self)

        switch resolveType {
        case .singleton:
            if let di = cache[diName] as? DI {
                return di
            } else {
                let di = factories[diName]?() as? DI

                if let di = di {
                    cache[diName] = di
                }

                return di
            }
        case .newSingleton:
            let di = factories[diName]?() as? DI

            if let di = di {
                cache[diName] = di
            }

            return di
        case .automatic:
            fallthrough
        case .new:
            return factories[diName]?() as? DI
        }
    }
}

