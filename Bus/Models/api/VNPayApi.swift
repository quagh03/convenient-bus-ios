//////
//////  VNPayApi.swift
//////  Bus
//////
//////  Created by Nguyễn Hữu Hiếu on 05/04/2024.
//////
////
//import Foundation
////import UIKit
////import SafariServices
//
//
//class VNPayApi: ObservableObject{
//
//    @Published var vnpayURL: QRCode?
//
//    @EnvironmentObject var dataHolder:  DataHolder
//
//    func submitOrder(amount: Int, orderInfo: String) {
//        
//        guard let url = URL(string: "http://localhost:8080/api/v1/vnpay/submitOrder?amount=\(amount)&orderInfo=\(orderInfo)") else {
//            print("Invalid URL")
//            return
//        }
//
//        // Tạo yêu cầu URLRequest
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET" // Hoặc POST, PUT, DELETE tùy vào yêu cầu của bạn
//        request.setValue("Bearer \(dataHolder.tokenLogin)", forHTTPHeaderField: "Authorization")
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else{
//                print("Error fetching")
//                return
//            }
//
//            do{
//                let decodedData = try JSONDecoder().decode(QRCode.self, from: data)
//                DispatchQueue.main.async {
////                    self.busRoutes = decodedData
//                    self.dataHolder.stringURL = decodedData.data
//
//                }
//            } catch{
//                print(String(describing: error))
//            }
//
//
//        }.resume()
//    }
//
//
//}
