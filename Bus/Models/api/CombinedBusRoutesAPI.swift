//
//  CombinedBusRoutesAPI.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 31/03/2024.
//

import Foundation
import SwiftUI

//class CombinedBusRoutesApi: ObservableObject {
//    @Published var combinedBusRoutes: [CombinedBusRoute] = []
//
//    func fetchData() {
//        // Fetch data for BusRoute
//        var busRoutes: [BusRoute] = []
//        let busRoutesApi = BusRoutesApi()
//        busRoutesApi.fetchData()
//        busRoutes = busRoutesApi.busRoutes
//
//        // Fetch data for BusRouteDetail
//        var busRouteDetails: [BusRouteDetail] = []
//        let busRoutesDetailApi = BusRoutesDetailApi()
//
//        for route in busRoutes {
//            busRoutesDetailApi.fetchData(nameRoute: route.routeName)
//            busRouteDetails = busRoutesDetailApi.busRouteDetail
//            for busRouteDetail in busRouteDetails {
//                if busRouteDetail.routeId.id == route.id {
//                    let combinedRoute = CombinedBusRoute(busRoute: route, busRouteDetail: busRouteDetail)
//                    combinedBusRoutes.append(combinedRoute)
//                }
//            }
//        }
//    }
//}

//class CombinedBusRoutesApi: ObservableObject {
//    @Published var combinedBusRoutes: [CombinedBusRoute] = []
//
//    func fetchData() {
//        let busRoutesApi = BusRoutesApi()
//        let busRoutesDetailApi = BusRoutesDetailApi()
//
//        busRoutesApi.fetchData()
//            let busRoutes = busRoutesApi.busRoutes
//
//            // Thực hiện lấy dữ liệu cho từng tuyến xe
//            for route in busRoutes {
//                busRoutesDetailApi.fetchData(nameRoute: route.routeName)
//                    let busRouteDetails = busRoutesDetailApi.busRouteDetail
//
//                    // Tìm và kết hợp thông tin tuyến xe
//                    for busRouteDetail in busRouteDetails {
//                        if busRouteDetail.routeId.id == route.id {
//                            let combinedRoute = CombinedBusRoute(busRoute: route, busRouteDetail: busRouteDetail)
//                            DispatchQueue.main.async {
//                                self.combinedBusRoutes.append(combinedRoute)
//                            }
//                        }
//
//                }
//            }
//
//    }
//}


class CombinedBusRoutesApi: ObservableObject {
    @Published var combinedBusRoutes: [CombinedBusRoute] = []
    
//    @EnvironmentObject var dataHolder: DataHolder
    
    func fetchData(nameRoute: String) {
        let busRouteUrl = URL(string: "\(DataHolder.url)/api/v1/bus_routes/all")
        let busRouteDetailUrl = URL(string: "\(DataHolder.url)/api/v1/route_details/route?name=\(nameRoute)")
        
        let busRouteDataTask = URLSession.shared.dataTask(with: busRouteUrl!) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching BusRoute")
                return
            }
            
            do {
                let busRouteData = try JSONDecoder().decode(BusRouteData.self, from: data)
                
                URLSession.shared.dataTask(with: busRouteDetailUrl!) { data, response, error in
                    guard let data = data, error == nil else {
                        print("Error fetching BusRouteDetail")
                        return
                    }
                    
                    do {
                        let busRouteDetailData = try JSONDecoder().decode(BusRouteDataDetail.self, from: data)
                        
                        DispatchQueue.main.async {
                            for busRoute in busRouteData.data {
                                if let busRouteDetail = busRouteDetailData.data.first(where: { $0.routeId.routeName == busRoute.routeName }) {
                                    self.combinedBusRoutes.append(CombinedBusRoute(busRoute: busRoute, busRouteDetail: busRouteDetail))
                                }
                            }
                        }
                    } catch {
                        print(String(describing: error))
                    }
                }.resume()
            } catch {
                print(String(describing: error))
            }
        }
        
        busRouteDataTask.resume()
    }
}

