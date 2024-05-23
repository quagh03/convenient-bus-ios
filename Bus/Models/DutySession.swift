//
//  DutySession.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 21/04/2024.
//

import Foundation

struct DutySession:Codable{
//    let driverID: Int
//    let routeID: Int
//    let vehicleID:Int
    
    let id: Int
    let vehicle: Vehicle
    let driver: User
    let route: BusRoute
    let startDate: String
    let endDate: String
}
