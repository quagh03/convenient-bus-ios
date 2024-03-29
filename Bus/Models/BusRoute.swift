//
//  busRoute.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 27/03/2024.
//

import Foundation

//struct BusRoute : Codable{
//    let id = UUID()
//    let data: [BusRouteData]
//}

struct BusRoute : Codable{
    let id: Int
    let routeName: String
//    let direction: String
    let startPoint: StopPoint
    let endPoint: StopPoint
//    let routeStop: [RouteStop]
}

struct StopPoint: Codable{
    let id: Int
    let stopPoint: String
}

struct RouteStop: Codable {
    let id: Int
    let stopPoint: String
}

struct BusRouteData:Codable{
    let data: [BusRoute]
}
