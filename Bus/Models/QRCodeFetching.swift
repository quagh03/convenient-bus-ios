//
//  QRCodeFetching.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 04/04/2024.
//

import Foundation

struct QRCodeFetching: Codable{
    let qrUrl: String
}

struct QRCode: Codable{
    let data: String
}
