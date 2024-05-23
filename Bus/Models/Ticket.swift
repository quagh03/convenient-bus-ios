//
//  Ticket.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 22/04/2024.
//

import Foundation

struct Ticket:Codable{
    let id: Int
    let startDate: String
    let endDate:String
    let user: User
}

struct TicketData:Codable{
    let data: [Ticket]
}
