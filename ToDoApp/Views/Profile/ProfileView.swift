//
//  ProfileView.swift
//  ToDoList
//
//  Created by Kiet Truong on 05/05/2023.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileVM
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var showAlert = false
    
    static func createInstance() -> ProfileView {
        let userService = UserServiceFirestore()
        let userRepo = UserRepositoryImp(service: userService)
        let profileVM = ProfileVM(userRepository: userRepo)
        return ProfileView(viewModel: profileVM)
    }
    
    var body: some View {
        BaseView(title: "Profile") {
            List {
                userView
                
                Button("Setting this") {}
                
                Button("Setting that") {}
                
                Button {
                    showAlert = true
                } label: {
                    Text("Log Out")
                        .foregroundColor(.red)
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Log Out"),
                        message: Text("Are you sure you want to log out?"),
                        primaryButton: .default(
                            Text("Cancel")
                        ),
                        secondaryButton: .destructive(
                            Text("Logout"),
                            action: {
                                viewModel.logOut()
                            }
                        )
                    )
                }
            }
        }
    }
    
    var userView: some View {
        HStack {
            PhotosPicker(selection: $avatarItem, matching: .images) {
                if let avatarImage {
                    avatarImage
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray)
                }
            }
        
            Spacer().frame(width: 16)
            
            VStack(alignment: .leading) {
                Text("Full Name")
                    .font(.title3)
                
                SpacingView(height: 8)
                
                Text("Email")
                    .font(.headline)
            }
        }
        .frame(height: 70)
        .onChange(of: avatarItem) { _ in
            Task {
                if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        avatarImage = Image(uiImage: uiImage)
                        return
                    }
                }
                
                print("Failed")
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView.createInstance()
    }
}
