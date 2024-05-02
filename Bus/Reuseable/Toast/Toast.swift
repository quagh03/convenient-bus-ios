//
//  ToastMessage.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 27/04/2024.
//

import SwiftUI

struct RootView<Content:View>: View{
    @ViewBuilder var content: Content
    // properties
    @State private var overlayWindow: UIWindow?
    var body: some View{
        content
            .onAppear{
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, overlayWindow == nil {
                    let window = PassthroughWindow(windowScene: windowScene)
                    window.backgroundColor = .clear
                    // view controller
                    let rootController = UIHostingController(rootView: ToastGroup())
                    rootController.view.frame = windowScene.keyWindow?.frame ?? . zero
                    rootController.view.backgroundColor = .clear
                    window.rootViewController = rootController
                    window.isHidden = false
                    window.isUserInteractionEnabled = true
                    window.tag = 100
                    
                    overlayWindow = window
                }
            }
    }
}

fileprivate class PassthroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event) else {return nil}
        
        return rootViewController?.view == view ? nil : view
    }
}

//@ObservableObject
class Toast: ObservableObject{
    static let shared = Toast()
    
    @Published fileprivate var toasts: [ToastItem] = []
    
    func present(title: String, symbol: String?, tint: Color = .primary, isUserInteractionEnabled: Bool = false, timing: ToastTime = .medium){
        toasts.append(.init(title: title, tint: tint, isUserInteractionEnabled: isUserInteractionEnabled, timing: timing))
    }
}

fileprivate struct ToastItem: Identifiable {
    let id: UUID = .init()
    var title: String
    var symbol: String?
    var tint: Color
    var isUserInteractionEnabled: Bool
        // timing
    var timing: ToastTime = .medium
}

enum ToastTime: CGFloat{
    case short = 1.0
    case medium = 2.0
    case long = 3.5
}

fileprivate struct ToastGroup: View{
    var model = Toast.shared
    var body: some View{
        GeometryReader{
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            ZStack{
                ForEach(model.toasts){
                    ToastView(size: size, item: $0)
                }
            }
            .padding(.bottom, safeArea.top == .zero ? 15 : 10)
            .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottom)
        }
    }
}

fileprivate struct ToastView: View{
    var size: CGSize
    var item: ToastItem
    @State private var animateIn: Bool = false
    @State private var animateOut: Bool = false
    var body: some View{
        HStack(spacing: 0){
            if let symbol = item.symbol {
                Image(systemName: symbol).font(.title)
                    .padding(.trailing, 10)
            }
            
            Text(item.title)
        }
        .foregroundColor(item.tint)
        .padding(.horizontal,15)
        .padding(.vertical,8)
        .background(
            Capsule()
                .fill(.background)
                .shadow(color: Color.primary.opacity(0.06), radius: 5, x: 5, y: 5)
                .shadow(color: Color.primary.opacity(0.06), radius: 8, x: -5, y: -5)
        )

        .contentShape(Capsule())
        .offset(y: animateIn ? 0 : 150)
        .offset(y: !animateOut ? 0 : 150)
        .task {
            guard !animateIn else { return }
            withAnimation(.easeOut(duration: 0.2)) {
                animateIn = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + item.timing.rawValue) {
                removeToast()
            }
            
        }
    }
    func removeToast(){
        guard !animateOut else {
            return
        }
        withAnimation {
            animateOut = true
        }
    }
}
