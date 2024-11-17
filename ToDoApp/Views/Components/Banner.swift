//
//  Banner.swift
//  ToDoList
//
//  Created by Kiet Truong on 28/06/2023.
//

import SwiftUI

struct BannerData {
    var title: String
    var message: String
    var type: BannerType
}

enum BannerType {
    case info
    case warning
    case success
    case error
    
    var tintColor: Color {
        switch self {
        case .info:
            return Color(red: 67/255, green: 154/255, blue: 215/255)
        case .success:
            return Color.green
        case .warning:
            return Color.yellow
        case .error:
            return Color.red
        }
    }
}

//final class BannerManager: ObservableObject {
//    @Published var isPresented: Bool = false
//
//    var banner: BannerData? {
//        didSet {
//            isPresented = banner != nil
//        }
//    }
//
//    public func dismiss() {
//        if isPresented {
//            isPresented = false
//        }
//    }
//
//    public func show(title: String, message: String, type: BannerType = .info) {
//        withAnimation {
//            banner = BannerData(title: title, message: message, type: type)
//        }
//    }
//}
//
//struct BannerView: View {
//    @ObservedObject var bannerManager: BannerManager
//
//    @State var dismissTask: DispatchWorkItem?
//
//    let animation = Animation.easeInOut(duration: 0.7)
//    let dismissDuration: Double = 3
//
//    var body: some View {
//        let isPresented = bannerManager.isPresented
//
//        VStack {
//            Spacer()
//
//            HStack {
//                VStack(alignment: .leading, spacing: 2) {
//                    Text(bannerManager.banner?.title ?? "")
//                        .bold()
//                    Text(bannerManager.banner?.message ?? "")
//                        .font(Font.system(size: 15, weight: Font.Weight.light, design: Font.Design.default))
//                }
//                Spacer()
//            }
//            .foregroundColor(Color.white)
//            .padding(12)
//            .background(bannerManager.banner?.type.tintColor ?? .blue)
//            .cornerRadius(8)
//            .shadow(radius: 20)
//        }
//        .padding()
//        .animation(animation, value: isPresented)
//        .transition(.move(edge: .bottom).combined(with: .opacity))
//        .onTapGesture {
//            // Close banner when tap
//            withAnimation {
//                bannerManager.dismiss()
//            }
//        }
//        .onAppear {
//            dismissTask = DispatchWorkItem {
//                withAnimation {
//                    bannerManager.dismiss()
//                }
//            }
//            // Auto dismiss after [dismissDuration] seconds, and cancel the task if view disappear before the auto dismiss
//            DispatchQueue.main.asyncAfter(deadline: .now() + dismissDuration, execute: dismissTask!)
//        }
//        .onDisappear {
//            dismissTask?.cancel()
//        }
//    }
//}
 
struct BannerModifier: ViewModifier {
    @Binding var data: BannerData?

    @State var dismissTask: DispatchWorkItem?

    let animation = Animation.easeInOut(duration: 0.7)
    let dismissDuration: Double = 4

    func body(content: Content) -> some View {
        let show = data != nil
        
        ZStack {
            content
            
            if show {
                VStack {
                    Spacer()

                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(data!.title)
                                .bold()
                            Text(data!.message)
                                .font(Font.system(size: 15, weight: Font.Weight.light, design: Font.Design.default))
                        }
                        Spacer()
                    }
                    .foregroundColor(Color.white)
                    .padding(12)
                    .background(data!.type.tintColor)
                    .cornerRadius(8)
                    .shadow(radius: 20)

                }
                .padding()
                .zIndex(1)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .onTapGesture {
                    // Close banner when tap
                    dismiss()
                }
                .onAppear {
                    dismissTask = DispatchWorkItem {
                        dismiss()
                    }
                    // Auto dismiss after [dismissDuration] seconds, and cancel the task if view disappear before the auto dismiss
                    DispatchQueue.main.asyncAfter(deadline: .now() + dismissDuration, execute: dismissTask!)
                }
                .onDisappear {
                    dismissTask?.cancel()
                }
            }
        }
        .animation(animation, value: show)
    }
    
    func dismiss() {
        data = nil
    }
}

extension View {
    func banner(data: Binding<BannerData?>) -> some View {
        modifier(BannerModifier(data: data))
    }
}
