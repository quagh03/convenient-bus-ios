//
//  Route.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 25/03/2024.
//

import SwiftUI

struct Route: View {
    @ObservedObject var viewModel = BusRoutesApi()
    @ObservedObject var viewModelDetail = BusRoutesDetailApi()
    
    @EnvironmentObject var dataHolder: DataHolder
    
    @State private var selectedRoute: BusRouteDetail?
    var busRouteDetail: [BusRouteDetail]?
    //    private let combinedBusRoute: CombinedBusRoute
    
    //    @ObservedObject var viewModel = CombinedBusRoutesApi()
    
    //    let busRouteDetail: BusRouteDetail?
    
    @State var isTap: Bool = false
    
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
                
                
            }
            
        }.fullScreenCover(isPresented: $isTap) {
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
