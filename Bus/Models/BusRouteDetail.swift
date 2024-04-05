//
//  BusRouteDetail.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 29/03/2024.
//

import Foundation

struct BusRouteDetail:Codable{
    let id: Int
    let routeId: RouteId
    let direction: String
    let startPoint: StopPoint
    let endPoint: StopPoint
    let routeStop: [RouteStop]
}

struct RouteId:Codable{
    let id: Int
    let routeName: String
    let startPoint: StopPoint
    let endPoint: StopPoint
    let price:Float
}

struct RouteStop: Codable {
    let id: Int
    let stop: Stop
    let index:Int
}

struct Stop: Codable{
    let id:Int
    let stopPoint: String
}


struct BusRouteDataDetail:Codable{
    let data: [BusRouteDetail]
}


struct CombinedBusRoute: Codable {
    let id: Int
    let routeName: String
    let startPoint: StopPoint
    let endPoint: StopPoint
    let direction: String
    let routeStop: [RouteStop]
    
    init(busRoute: BusRoute, busRouteDetail: BusRouteDetail) {
        self.id = busRoute.id
        self.routeName = busRoute.routeName
        self.startPoint = busRoute.startPoint
        self.endPoint = busRoute.endPoint
        self.direction = busRouteDetail.direction
        self.routeStop = busRouteDetail.routeStop
    }
}
