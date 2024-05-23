//
//  TransactionAPI.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 15/04/2024.
//

import Foundation
import SwiftUI

class TransactionAPI: ObservableObject {
    @Published var buyTicketSuccess: Bool?
    @Published var buyTicketFailed: Bool?
    @Published var isShow: Bool = false
    
    @Published var allTransactions: [Transaction] = []
    @Published var inTrans: [Transaction] = []
    @Published var outTrans: [Transaction] = []
    
    
    func deposit(tokenLogin: String, startDate: String, periods: Int, price: Double) async throws{
        guard let url = URL(string: "\(DataHolder.url)/api/v1/tickets") else {
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
            request.addValue("Bearer \(tokenLogin)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
            request.httpBody = jsonData
            
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                guard let httpResponse = response as? HTTPURLResponse else {
//                    print("Invalid response")
//                    return
//                }
//                if httpResponse.statusCode == 200 {
//                    print("Mua vé thành công")
//                    self.buyTicketSuccess = true
//                    self.isShow = true
//                } else {
//                    print("Mua vé không thành công")
//                    self.buyTicketSuccess = false
//                    self.isShow = false
//                }
//            }.resume()
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if httpResponse.statusCode == 200 {
                print("Mua vé thành công")
                DispatchQueue.main.async {
                    self.buyTicketSuccess = true
                    self.isShow = true
                }
            } else {
                print("Mua vé không thành công")
                DispatchQueue.main.async {
                    self.buyTicketSuccess = false
                    self.isShow = false
                }
            }
        }catch{
            print("error")
        }
    }
    
    func getAllTransaction(tokenLogin: String, userId: Int){
        guard let url = URL(string: "\(DataHolder.url)/api/v1/transactions") else { return }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(tokenLogin)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Error fetching")
                return 
            }
            
            do{
                let decodedData = try JSONDecoder().decode(TransactionData.self, from: data)
                DispatchQueue.main.async {
                    self.allTransactions = decodedData.data.filter{$0.user.id == userId}.sorted{$0.time > $1.time}
                    self.inTrans = decodedData.data.filter{$0.type == "IN" && $0.user.id == userId}.sorted{$0.time > $1.time}
                    self.outTrans = decodedData.data.filter{$0.type == "OUT" && $0.user.id == userId}.sorted{$0.time > $1.time}
                }
            }catch{
                print(error)
            }
        }.resume()
    }
}
