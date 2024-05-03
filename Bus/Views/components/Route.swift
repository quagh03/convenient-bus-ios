//
//  Route.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 25/03/2024.
//

import SwiftUI
import UIKit

struct Route: View {
    @ObservedObject var viewModel = BusRoutesApi()
    @ObservedObject var viewModelDetail = BusRoutesDetailApi()
    
    @EnvironmentObject var dataHolder: DataHolder
    
    @State private var selectedRoute: BusRouteDetail?
    var busRouteDetail: [BusRouteDetail]?
    
    @State var isTap: Bool = false
    @State private var bottomPadding: CGFloat = 0
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack(){
                    ReusableImage(color: "primary", height: 60, width: .infinity)
                    Text("Tuyến xe").foregroundColor(.white)
                        .bold()
                        .font(.system(size: 25))
                }
                ReusableSearchbar(searchKey: "")
                //                .offset(y:-80)
                    .padding(.horizontal)
                
                VStack {
                    ForEach(viewModel.busRoutes, id: \.id) { busRoute in
                        RouteRow(busRoute: busRoute)
                            .onTapGesture {
                                print(busRoute.routeName)
                                dataHolder.nameRouteDetail = busRoute.routeName
                                isTap = true
                            }
                    }
                }
                //            .offset(y:-80)
                .padding(.all)
                .onAppear {
                    viewModel.fetchData()
                }
                
                Spacer()
                // end VStack 1
            }.padding(.top, bottomPadding)
                .navigationBarHidden(true)
                .edgesIgnoringSafeArea(.top)
            
            
        }
        .onAppear {
            // Đặt giá trị cho bottomPadding khi view được hiển thị
            if let window = UIApplication.shared.windows.first {
                bottomPadding = window.safeAreaInsets.bottom
            }
        }
        .fullScreenCover(isPresented: $isTap) {
            DetailBusRoute(nameRouteDetail: dataHolder.nameRouteDetail!)
        }
        // end navigationView
    }
}

struct Route_Previews: PreviewProvider {
    static var previews: some View {
        Route()
    }
}
