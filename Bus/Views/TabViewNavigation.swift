//
//  TabView.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 25/03/2024.
//

import SwiftUI

struct TabViewNavigation: View {
    @State private var selectedTabIndex = 0
    @State private var isTabBarHidden = false
    var body: some View {
        ZStack(alignment: .bottom){
            TabView{
                Home(selection: $selectedTabIndex)
                    .tabItem{
                        Image(systemName: "house.fill")
                        Text("Home")
                    }.tag(0)
                Payment()
                    .tabItem{
                        Image(systemName: "creditcard.fill")
                        Text("payment")
                    }.tag(1)
                Route()
                    .tabItem{
                        Image(systemName: "map.fill")
                        Text("Route")
                    }.tag(2)
                Account()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Account")
                    }.tag(3)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

//struct TabView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabViewNavigation()
//    }
//}
