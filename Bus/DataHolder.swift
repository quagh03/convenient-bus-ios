//
//  DataHolder.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 30/03/2024.
//

import Foundation
import Combine

class DataHolder : ObservableObject{
    static let shared = DataHolder()
    private let defaults = UserDefaults.standard
    
    private let usernameKey = "Username"
    private let passwordKey = "Password"
    
    var savedUsername: String? {
        get {
            return defaults.string(forKey: usernameKey)
        }
        set {
            defaults.set(newValue, forKey: usernameKey)
        }
    }
    
    var savedPassword: String? {
        get {
            return defaults.string(forKey: passwordKey)
        }
        set {
            defaults.set(newValue, forKey: passwordKey)
        }
    }
    func clearSavedCredentials() {
        defaults.removeObject(forKey: usernameKey)
        defaults.removeObject(forKey: passwordKey)
    }
    
    // url
    static let url: String = "http://103.170.123.135:8080"
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
    @Published var sessionId: Int?
    
    // add trip
    @Published var isAddTripSuccess: Bool
    
    // check
    @Published var check1:Bool = false
    @Published var check2:Bool = false
    
    
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
        // add trip
        self.isAddTripSuccess = false
    }
    
    func logout(){
        // Xóa token đăng nhập
        self.tokenLogin = ""
        
        // Đặt lại tất cả các thuộc tính khác về giá trị mặc định
        self.idUser = nil
        self.fNameUser = nil
        self.lNameUser = nil
        self.emailUser = nil
        self.phoneUser = nil
        self.dobUser = nil
        
        self.nameRouteHolder = nil
        self.busRouteDetail = nil
        self.nameRouteDetail = nil
        
        self.isTabBarHidden = false
        
        self.stringURL = nil
        self.webViewUrl = nil
        
        self.priceTicket = nil
        self.numOfTicket = nil
        self.date = nil
        self.date1 = nil
        
        self.isExistTicket = false
        
        self.buyTicketSuccess = false
        self.buyTicketFailed = false
        
        self.type = nil
        self.vnpID = nil
        self.time = nil
        self.amount = nil
        self.status = nil
        self.firstNamePH = nil
        self.lastNamePH = nil
        self.phoneNumberPH = nil
        self.emailPH = nil
        
        self.nameRouteDd = nil
        self.nameVehicleDd = nil
        self.routeIDDd = nil
        self.vehicleIDDd = nil
        
        self.isStartSession = false
        
        self.isAddTripSuccess = false
        
        self.check1 = false
        self.check2 = false
    }

}
