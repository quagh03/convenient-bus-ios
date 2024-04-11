//
//  user.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 18/03/2024.
//

import Foundation

struct User:Codable{
    let id: Int
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let username: String
    let password: String
    let email: String
    let gender: String
    let dob: String
    let registeredAt: String
    let balance: Float
}

struct Userdata: Codable{
    let data: User
}
