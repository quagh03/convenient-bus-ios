//
//  Transaction.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 17/04/2024.
//

import Foundation

struct Transaction:Codable{
    let id: Int
    let amount: Double
    let type: String
    let vnpID: String?
    let time: String
    let status: String
    let user: User
}


struct TransactionData:Codable{
    let data: [Transaction]
}
