//
//  ContentView.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 12/03/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dataHolder = DataHolder()
    @EnvironmentObject var networkMonitor: NetworkMonitor
    var body: some View {
        VStack{
            ZStack{
                SplashScreen().environmentObject(dataHolder)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} 
