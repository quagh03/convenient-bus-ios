////
////  VNPayApi.swift
////  Bus
////
////  Created by Nguyễn Hữu Hiếu on 05/04/2024.
////
//
//import Foundation
//import UIKit
//import SafariServices
//
//class VNPayApi: ObservableObject{
//    func submitOrder(amount:Int, orderInfo:String){
//        guard let url = URL(string: "http://localhost:8080/api/v1/vnpay/submitOrder?amount=\(amount)&orderInfo=\(orderInfo)") else {
//            print("Invalid URL")
//            return
//        }
//        // https://www.google.com/
//        
//                UIApplication.shared.open(url)
////        if let keyWindow = UIApplication.shared.connectedScenes
////                .compactMap({ $0 as? UIWindowScene })
////                .flatMap({ $0.windows })
////                .first(where: { $0.isKeyWindow }) {
////
////                // Check if another view controller is already presented
////                if keyWindow.rootViewController?.presentedViewController == nil {
////                    let safariViewController = SFSafariViewController(url: url)
////                    keyWindow.rootViewController?.present(safariViewController, animated: true, completion: nil)
////                } else {
////                    print("Another view controller is already presented.")
////                }
////            } else {
////                print("No key window found.")
////            }
//    }
//}

//import Foundation
//import SafariServices
//
//class VNPayApi: ObservableObject {
//    @EnvironmentObject var dataHolder: DataHolder
//
//    func submitOrder(amount: Int, orderInfo: String) {
//        guard let token = dataHolder.tokenLogin else {
//            print("Token not found")
//            return
//        }
//
//        guard let url = URL(string: "http://localhost:8080/api/v1/vnpay/submitOrder") else {
//            print("Invalid URL")
//            return
//        }
//
//        // Tạo yêu cầu URLRequest
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET" // Hoặc POST, PUT, DELETE tùy vào yêu cầu của bạn
//        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//
//        // Hiển thị SafariViewController để mở URL
//        if let safariViewController = getTopMostViewController()?.presentedViewController as? SFSafariViewController {
//            safariViewController.dismiss(animated: false, completion: nil)
//        }
//
//        let safariViewController = SFSafariViewController(url: url)
//        getTopMostViewController()?.present(safariViewController, animated: true, completion: nil)
//    }
//
//    private func getTopMostViewController() -> UIViewController? {
//        var topMostViewController = UIApplication.shared.windows.first?.rootViewController
//
//        while let presentedViewController = topMostViewController?.presentedViewController {
//            topMostViewController = presentedViewController
//        }
//
//        return topMostViewController
//    }
//}
