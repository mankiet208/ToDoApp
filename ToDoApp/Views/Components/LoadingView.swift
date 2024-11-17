//
//  LoadingView.swift
//  ToDoList
//
//  Created by Kiet Truong on 19/06/2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .controlSize(.large)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
