//
//  SplashScreen.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 12/03/2024.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isVisible = false
    var body: some View {
        if isVisible{
            Login()
        }else{
            VStack{
                Image("splashScreen")
                    .resizable()
                    .ignoresSafeArea()
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                    withAnimation{
                        self.isVisible = true
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
