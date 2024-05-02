//
//  DataHolder.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 30/03/2024.
//

import Foundation
import Combine

class DataHolder : ObservableObject{
    // userPresemt
    @Published var idUser: Int?
    @Published var fNameUser: String?
    @Published var lNameUser: String?
    @Published var emailUser: String?
    @Published var phoneUser: String?
    @Published var dobUser: String?
    
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
    
    // ticket
    @Published var isExistTicket: Bool = false
    
    // alert buy ticket
    @Published var buyTicketSuccess: Bool
    @Published var buyTicketFailed: Bool
    
    // info detail payment history
    @Published var type: String?
    @Published var vnpID: String?
    @Published var time: String?
    @Published var amount: Double?
    @Published var status: String?
    @Published var firstNamePH: String?
    @Published var lastNamePH: String?
    @Published var phoneNumberPH: String?
    @Published var emailPH: String?
    
//    @Published var imgNamePaymentHistory: String
    // dropdown save nameroute
    @Published var nameRouteDd: String?
    @Published var nameVehicleDd: String?
    @Published var routeIDDd: Int?
    @Published var vehicleIDDd: Int?
    
    //
    @Published var isStartSession: Bool
    
    
    init() {
        self.nameRouteHolder = "initial name"
        self.nameRouteDetail = "initial"
        self.tokenLogin = "initial token"
        //alert buy ticket
        self.buyTicketSuccess = false
        self.buyTicketFailed = false
        //
        self.webViewUrl = nil
        // session
        self.isStartSession = false
    }
    
    func logout(){
        self.tokenLogin = ""
    }
}
