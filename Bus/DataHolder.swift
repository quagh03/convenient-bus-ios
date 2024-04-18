//
//  DataHolder.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 30/03/2024.
//

import Foundation
import Combine

class DataHolder : ObservableObject{
    @Published var idUser: Int?
    
    @Published var nameRouteHolder: String?
    @Published var busRouteDetail: [BusRouteDetail]?
    @Published var nameRouteDetail: String?
    
    @Published var isTabBarHidden = false
    @Published var tokenLogin: String
    
    @Published var stringURL: String?
    
    @Published var webViewUrl: URL?
    
    // buy ticket
    @Published var priceTicket: Int?
    @Published var numOfTicket: Int?
    @Published var date: String?
    @Published var date1: Date?
    
    // alert buy ticket
    @Published var buyTicketSuccess: Bool
    @Published var buyTicketFailed: Bool
    
    init() {
        self.nameRouteHolder = "initial name"
        self.nameRouteDetail = "initial"
        self.tokenLogin = "initial token"
        //alert buy ticket
        self.buyTicketSuccess = false
        self.buyTicketFailed = false
        //
        self.webViewUrl = nil
    }
}
