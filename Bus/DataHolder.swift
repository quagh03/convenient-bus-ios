//
//  DataHolder.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 30/03/2024.
//

import Foundation
import Combine

class DataHolder : ObservableObject{
    @Published var nameRouteHolder: String?
    @Published var busRouteDetail: [BusRouteDetail]?
    @Published var nameRouteDetail: String?
    
    @Published var isTabBarHidden = false
    
    init() {
        self.nameRouteHolder = "initial name"
        self.nameRouteDetail = "initial"
    }
}
