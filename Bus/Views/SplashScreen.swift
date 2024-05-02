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
    
    var body: some View {
        if isVisible{
            if monitor.isConnected{
                Login()
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
//                    Text("Bus Convenient App").font(.system(size: 25))
//                        .foregroundColor(.black.opacity(0.7))
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
                    self.isVisible = true
                }
            }
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
