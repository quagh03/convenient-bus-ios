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
    var dataHolder = DataHolder()
    let tabBarSetting = DataHolder()
    let favorites = Favotites()
    var body: some Scene {
        WindowGroup {
            //            SplashScreen()
            //            ContentView().environmentObject(navigationManager)
//            RootView{
                ContentView()
                    .environmentObject(navigationManager)
                    .environmentObject(dataHolder)
                    .environmentObject(favorites)
//            }
            
        }
    }
}

