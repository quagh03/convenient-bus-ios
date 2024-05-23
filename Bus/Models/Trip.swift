//
//  TripHistory.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 29/04/2024.
//

import Foundation

struct Trip:Codable {
    let id: Int
    let user: User
    let dutySession: DutySession
    let date: String
}

struct TripData:Codable{
    let data: [Trip]
}
