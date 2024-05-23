//
//  TicketAPI.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 22/04/2024.
//

import Foundation
import SwiftUI

class TicketAPI:ObservableObject{
    @Published var ticket: [Ticket] = []
    @Published var ticketForUser: [Ticket] = []
    @Published var isExist: Bool = false
    
    @Published var isExpireTicket: Bool?
    @Published var isShowing: Bool = false
    
    
    
    func getAllTicket(tokenLogin: String, userID: Int) async throws {
        guard let url = URL(string: "\(DataHolder.url)/api/v1/tickets") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(tokenLogin)", forHTTPHeaderField: "Authorization")
        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data else {
//                print("Invalid response")
//                return
//            }
//            do{
//                let decodedData = try JSONDecoder().decode(TicketData.self, from: data)
//                DispatchQueue.main.async {
//                    self.ticket = decodedData.data
//                    self.ticketForUser = decodedData.data.filter{$0.user.id == userID}
//                    if self.ticketForUser.isEmpty{
//                        self.isExist = false
//                    } else {
//                        self.isExist = true
//                    }
//                }
//            }catch{
//                print(error)
//            }
//        }.resume()
        
        let (data, _) = try await URLSession.shared.data(for: request)
        do {
            let decodedData = try JSONDecoder().decode(TicketData.self, from: data)
            DispatchQueue.main.async {
                self.ticket = decodedData.data
                self.ticketForUser = decodedData.data.filter{$0.user.id == userID}
                if self.ticketForUser.isEmpty{
                    self.isExist = false
                } else {
                    self.isExist = true
                }
            }
        } catch {
            print(error)
        }
    }
    
    // gia han
    func exprireTiket(tokenLogin: String, startDate: String, periods: Int, price: Double) async throws{
        guard let url = URL(string: "\(DataHolder.url)/api/v1/tickets/extend") else {
            print("Invalid url expire ticket")
            return
        }
        
        let dataTicket: [String : Any] = [
            "start_date": startDate,
            "periods": periods,
            "price": price
        ]
        
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: dataTicket)
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.addValue("Bearer \(tokenLogin)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
            request.httpBody = jsonData
            
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                guard let httpResponse = response as? HTTPURLResponse else {
//                    print("Invalid response expire ticket")
//                    return
//                }
//                if httpResponse.statusCode == 200 {
//                    print("Gia hạn thành công")
//                    DispatchQueue.main.async{
//                        self.isExpireTicket = true
//                        self.isShowing = true
//                    }
//                } else {
//                    print("Gia hạn thất bại")
//                    DispatchQueue.main.async{
//                        self.isExpireTicket = false
//                        self.isShowing = false
//                    }
//                }
//            }.resume()
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response expire ticket")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("Gia hạn thành công")
                DispatchQueue.main.async {
                    self.isExpireTicket = true
                    self.isShowing = true
                }
            } else {
                print("Gia hạn thất bại")
                DispatchQueue.main.async {
                    self.isExpireTicket = false
                    self.isShowing = false
                }
            }
            
        }catch{
            
        }
    }
    
}
