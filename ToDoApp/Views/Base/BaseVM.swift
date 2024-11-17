//
//  BaseViewModel.swift
//  ToDoList
//
//  Created by Kiet Truong on 04/07/2023.
//

import Foundation

class BaseVM: ObservableObject {
    enum State {
        case idle
        case loading
    }
    
    @Published var state = State.idle
    @Published var bannerData: BannerData?
}
