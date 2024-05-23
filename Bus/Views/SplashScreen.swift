//
//  SplashScreen.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 12/03/2024.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isVisible = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    @ObservedObject var monitor = NetworkMonitor()
    
    @EnvironmentObject var dataHolder: DataHolder
    
    var body: some View {
        NavigationView{
            VStack{
                if isVisible{
                    if monitor.isConnected{
                        Login().navigationBarHidden(true)
                    } else {
                        CheckNetwork {
                            restartApp()
                        }
                    }
                }else{
                    VStack{
                        VStack{
                            Image("splashscreen")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150,height: 150)
                                .ignoresSafeArea()
                        }
                        .scaleEffect(size)
                        .opacity(opacity)
                        .onAppear{
                            withAnimation {
                                self.size = 0.9
                                self.opacity = 1
                            }
                        }
                    }.onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                            withAnimation{
                                self.isVisible = true
                            }
                        }
                    }
                }
            }.navigationBarHidden(true)
                .edgesIgnoringSafeArea(.top)
        }
        
    }
    
    func restartApp() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        UIApplication.shared.windows.forEach { window in
            window.rootViewController = UIHostingController(rootView: SplashScreen())
            window.makeKeyAndVisible()
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

//import SwiftUI
//import UIKit
//
//struct SplashScreen: View {
//    @State private var isVisible = false
//    @State private var size = 0.8
//    @State private var opacity = 0.5
//
//    @ObservedObject var monitor = NetworkMonitor()
//
//    @EnvironmentObject var dataHolder: DataHolder
//
//    var body: some View {
//        VStack{
//            VStack{
//                Image("splashscreen")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 150,height: 150)
//                    .ignoresSafeArea()
//            }
//            .scaleEffect(size)
//            .opacity(opacity)
//            .onAppear{
//                withAnimation {
//                    self.size = 0.9
//                    self.opacity = 1
//                }
//            }
//        }.onAppear{
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
//                self.isVisible = true
//                navigateToLoginIfNeeded()
//            }
//        }
//    }
//
//    func navigateToLoginIfNeeded() {
//        if monitor.isConnected {
//            // Nếu có kết nối mạng, chuyển đổi sang màn hình Login
//            restartApp()
//        } else {
//            // Nếu không có kết nối mạng, hiển thị thông báo lỗi
//            CheckNetwork {
//                restartApp()
//            }
//        }
//    }
//
//    func restartApp() {
//        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
//        UIApplication.shared.windows.forEach { window in
//            window.rootViewController = UIHostingController(rootView: Login().environmentObject(dataHolder))
//            window.makeKeyAndVisible()
//        }
//    }
//}
