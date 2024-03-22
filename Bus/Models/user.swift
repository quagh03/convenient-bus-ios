//
//  user.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 18/03/2024.
//

import Foundation

struct user:Codable{
    let id: Int
    let firstName: String
    let lastName: String
    let phone: String
    let userName: String
    let password: String
    let email: String
    let chooseGender: String
    let birth: Date
}
