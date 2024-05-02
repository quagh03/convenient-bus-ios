//
//  TabView.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 25/03/2024.
//

import SwiftUI

struct TabViewNavigation: View {
    @EnvironmentObject var dataHolder: DataHolder
    @State private var selectedTabIndex = 0
    @State private var isTabBarHidden = false
    @StateObject var userAPI = UserAPI()
    @State private var isPress: Bool = false
    @State private var isLogOut: Bool = false
    var body: some View {
        ZStack(alignment: .bottom){
            if userAPI.role == "ROLE_DRIVER" {
                TabView{
                    if selectedTabIndex == 0 {
                        Driver()
                } else if selectedTabIndex == 1 {
                    Account(isLogOut: $isLogOut)
                    }
                }.navigationBarBackButtonHidden(true).ignoresSafeArea()
                
                CustomTabNavDriver(index: $selectedTabIndex, isPress: $isPress).navigationBarBackButtonHidden(true).ignoresSafeArea()
                
            } else if userAPI.role == "ROLE_GUEST" {
                TabView{
                    Home(selection: $selectedTabIndex)
                        .tabItem{
                            Image(systemName: "house.fill")
                            Text("Home")
                        }.tag(0)
                    Payment()
                        .tabItem{
                            Image(systemName: "creditcard.fill")
                            Text("Payment")
                        }.tag(1)
                    Route()
                        .tabItem{
                            Image(systemName: "map.fill")
                            Text("Route")
                        }.tag(2)
                    Account(isLogOut: $isLogOut)
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("Account")
                        }.tag(3)
                    
                }
                .navigationBarBackButtonHidden(true)
            }
        }
//        .onChange(of: $isLogOut) { newValue in
//            if newValue {
//                NavigationLink(destination: Login(), isActive: $isLogOut) {
//                    EmptyView()
//                }
//            }
//        }
        .onAppear{
            userAPI.getUser(tokenLogin: dataHolder.tokenLogin)
        }
        .fullScreenCover(isPresented: $isPress) {
            ScannerView()
        }
        .ignoresSafeArea()
        .background(
            NavigationLink(destination: Login(), isActive: $isLogOut) {
                               EmptyView()
                           }
        )
    }
}

//struct TabView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabViewNavigation()
//    }
//}
