//
//  TabView.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 25/03/2024.
//

import SwiftUI
import UIKit

struct TabViewNavigation: View {
    @EnvironmentObject var dataHolder: DataHolder
    @State private var selectedTabIndex = 0
    @State private var isTabBarHidden = false
    @StateObject var userAPI = UserAPI()
    @State private var isPress: Bool = false
    @State private var isLogOut: Bool = false
    @State private var check: Bool = false
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottom){
                if userAPI.role == "ROLE_DRIVER" {
                    TabView{
                        if selectedTabIndex == 0 {
                            Driver(check: $check)
                                .navigationBarHidden(true).edgesIgnoringSafeArea(.top)
                        } else if selectedTabIndex == 1 {
                            Account(isLogOut: $isLogOut).navigationBarHidden(true)
                        }
                    }
                    //                .navigationBarBackButtonHidden(true).ignoresSafeArea()
                    
                    CustomTabNavDriver(index: $selectedTabIndex, isPress: $isPress).navigationBarHidden(true).edgesIgnoringSafeArea(.bottom)
                    //                    .navigationBarBackButtonHidden(true).ignoresSafeArea()
                    
                } else if userAPI.role == "ROLE_GUEST" {
                    TabView{
                        Home(selection: $selectedTabIndex).navigationBarHidden(true)
                            .tabItem{
                                Image(systemName: "house.fill")
                                Text("Home")
                            }.tag(0)
                        Payment().navigationBarHidden(true).edgesIgnoringSafeArea(.top)
                            .tabItem{
                                Image(systemName: "creditcard.fill")
                                Text("Payment")
                            }.tag(1)
                        Route().navigationBarHidden(true)
                            .tabItem{
                                Image(systemName: "map.fill")
                                Text("Route")
                            }.tag(2)
                        Account(isLogOut: $isLogOut).navigationBarHidden(true)
                            .tabItem {
                                Image(systemName: "person.fill")
                                Text("Account")
                            }.tag(3)
                        
                    }
                    //                .navigationBarBackButtonHidden(true)
                } else if userAPI.role == "ROLE_ADMIN"{
                    TabView{
                        Home(selection: $selectedTabIndex).navigationBarHidden(true)
                            .tabItem{
                                Image(systemName: "house.fill")
                                Text("Home")
                            }.tag(0)
                        Payment().navigationBarHidden(true)
                            .tabItem{
                                Image(systemName: "creditcard.fill")
                                Text("Payment")
                            }.tag(1)
                        Route().navigationBarHidden(true)
                            .tabItem{
                                Image(systemName: "map.fill")
                                Text("Route")
                            }.tag(2)
                        Driver(check: $check).navigationBarHidden(true)
                            .tabItem {
                                Image(systemName: "car.fill")
                                Text("Driver")
                            }.tag(3)
                        Account(isLogOut: $isLogOut).navigationBarHidden(true)
                            .tabItem {
                                Image(systemName: "person.fill")
                                Text("Account")
                            }.tag(4)
                    }
                }
            }
            //        .onChange(of: $isLogOut) { newValue in
            //            if newValue {
            //                NavigationLink(destination: Login(), isActive: $isLogOut) {
            //                    EmptyView()
            //                }
            //            }
            //        }
            
            NavigationLink(destination: Login(), isActive: $isLogOut){
                EmptyView()
            }
            
        }.navigationBarHidden(true)
        .onAppear{
            Task{
                do{
                    try await userAPI.getUser(tokenLogin: dataHolder.tokenLogin)
                }catch{
                    print("Error fetching user data: \(error)")
                }
               
            }
        }
        .fullScreenCover(isPresented: $isPress) {
            ScannerView(check: $check)
        }
//        .edgesIgnoringSafeArea(.top)
//        .ignoresSafeArea()
//        .background(
//            NavigationLink(destination: Login(), isActive: $isLogOut) {
//                EmptyView()
//            }
//        )
    }
}

//struct TabView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabViewNavigation()
//    }
//}
