//
//  DetailBusRoute.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 28/03/2024.
//

import SwiftUI
import SlidingTabView

struct DetailBusRoute: View {
    @State private var selectedTab = 0
    
    @ObservedObject var viewModel = BusRoutesDetailApi()
    
    @EnvironmentObject var tabBarSettings: DataHolder
    
    @Environment(\.presentationMode) var presentationMode
    //    let routeDetail: [BusRouteDetail]
//    @State var nameInfo: String
    
    var nameRouteDetail: String
    
    @State private var direction: String = "DEPARTURE"
    
    var departureRoutes: [BusRouteDetail] = []
    var returnRoutes: [BusRouteDetail] = []
    var infoDeparture: [BusRouteDetail] = []
    var infoReturn: [BusRouteDetail] = []
    
    var body: some View {
        ZStack{
//            Button {
//                presentationMode.wrappedValue.dismiss()
//            } label: {
//                Image(systemName: "chevron.left")
//                                    .foregroundColor(.blue)
//            }

            VStack{
                BarBackCustom( nameRoute: nameRouteDetail).padding(.bottom,15)
                HStack{
                    // name route
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color("primary"))
                        .frame(width: 50, height: 50)
                        .overlay{
                            Text(nameRouteDetail)
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                                .bold()
                        }
                    
                    // direction
                    VStack(alignment:.leading){
                        Text("Chiều đi - xuất phát từ:").padding(.bottom,1)
                        //                        Text(direction == "DEPARTURE" ? "\(viewModel.departureRoutes[0].startPoint.stopPoint)" : "\(viewModel.returnRoutes[0].startPoint.stopPoint)").padding(.top,-4)
                        if direction == "DEPARTURE" {
                            ForEach(viewModel.departureRoutes, id: \.id) { dp in
                                Text("\(dp.startPoint.stopPoint)")
                            }
                        } else {
                            ForEach(viewModel.returnRoutes, id: \.id) { rt in
                                Text("\(rt.startPoint.stopPoint)")
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        if direction == "DEPARTURE"{
                            direction = "RETURN"
                        }else{
                            direction = "DEPARTURE"
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color("primary"))
                            .frame(width: 102, height: 50)
                            .overlay{
                                //                                Button(action:{
                                //                                    if direction == "DEPARTURE"{
                                //                                        direction = "RETURN"
                                //                                    }else{
                                //                                        direction = "DEPARTURE"
                                //                                    }
                                //                                }){
                                HStack{
                                    Image("switch1")
                                        .renderingMode(.template)
                                        .resizable()
                                        .frame(width: 20,height: 20)
                                        .foregroundColor(.white)
                                    Text(direction == "DEPARTURE" ? "Chiều đi" : "Chiều về")
                                        .foregroundColor(.white)
                                        .font(.system(size: 14))
                                }
                                //                                }
                            }
                    }
                    
                    ///end HStack
                }
                
                SlidingTabView(selection: $selectedTab, tabs: ["Trạm dừng", "Thông tin"], animation: .easeInOut, activeAccentColor: .blue, selectionBarColor: .blue)
                Spacer()
                // chiều đi
                
                if direction == "DEPARTURE"{
                    if selectedTab==0 {
                        VStack{
                            ScrollView{
                                ForEach(viewModel.departureRoutes, id: \.id) {departure in
                                    ForEach(departure.routeStop, id: \.id) { routeStop in
                                        StopRoute(busRouteDetailStopName: routeStop.stopPoint)
                                    }
                                }
                            }
                        }.tag(0)
                    } else if selectedTab == 1{
                        VStack{
                            ScrollView{
                                ForEach(viewModel.inforDeparture, id: \.id) {infod in
                                    InforRoute(infod: infod)
                                }
                            }
                        }.tag(1)
                    }
                } else if direction == "RETURN" {
                    if selectedTab==0 {
                        VStack{
                            ScrollView{
                                ForEach(viewModel.returnRoutes, id: \.id) {departure in
                                    ForEach(departure.routeStop, id: \.id) { routeStop in
                                        StopRoute(busRouteDetailStopName: routeStop.stopPoint)
                                    }
                                }
                            }
                        }.tag(0)
                    } else if selectedTab == 1{
                        VStack{
                            ScrollView{
                                ForEach(viewModel.inforReturn, id: \.id) {infod in
                                    InforRoute(infod: infod)
                                }
                            }
                        }.tag(1)
                    }
                }
                
            }
            // end VStack
        }
        .onAppear{
            viewModel.fetchData(nameRoute: nameRouteDetail)
        }
        .padding(.all)
        // end ZStack
    }
}



struct DetailBusRoute_Previews: PreviewProvider {
    static var previews: some View {
        DetailBusRoute(nameRouteDetail: "E01")
    }
}
