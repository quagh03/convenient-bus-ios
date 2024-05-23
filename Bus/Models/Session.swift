//
//  Session.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 27/04/2024.
//

import Foundation

struct Session:Codable{
    let id: Int
}

struct SessionData:Codable{
    let data: Session
}
