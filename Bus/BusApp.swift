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
    @StateObject var dataHolder = DataHolder()
    let tabBarSetting = DataHolder()
    let favorites = Favorites()
    @StateObject var networkMonitor = NetworkMonitor()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationManager)
                .environmentObject(dataHolder)
                .environmentObject(favorites)
                .environmentObject(networkMonitor)
        }
    }
}

