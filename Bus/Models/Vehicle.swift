//
//  Vehicle.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 25/04/2024.
//

import Foundation

struct Vehicle:Codable{
    let id:Int
    let plateNumber: String
}

struct VehicleData:Codable{
    let data: [Vehicle]
}
