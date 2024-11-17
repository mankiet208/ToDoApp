//
//  DI.swift
//  ToDoList
//
//  Created by Kiet Truong on 28/06/2023.
//

import Foundation

@propertyWrapper
struct DI<DI> {
    
    var di: DI
    
    init(_ diType: DIType = .automatic) {
        guard let di = DIContainer.resolve(diType, DI.self) else {
            let diName = String(describing: DI.self)
            fatalError("No dependency of type \(diName) registered!")
        }
        self.di = di
    }
    
    var wrappedValue: DI {
        get { di }
        mutating set { di = newValue }
    }
}
