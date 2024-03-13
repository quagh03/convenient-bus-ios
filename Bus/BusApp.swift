//
//  BusApp.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 12/03/2024.
//

import SwiftUI

@main
struct BusApp: App {
    let navigationManager = NavigationManager.shared
    var body: some Scene {
        WindowGroup {
            //            SplashScreen()
            //            ContentView().environmentObject(navigationManager)
            ContentView()
                .environmentObject(navigationManager)
        }
    }
}
