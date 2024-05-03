//
//  UserAPI.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 10/04/2024.
//

import Foundation
import SwiftUI

class UserAPI: ObservableObject {
    
    @Published var user: User?
    @Published var balance: Float?
    @Published var id : Int?
    @Published var firstName: String?
    @Published var lastName: String?
    @Published var phoneNumber: String?
    @Published var email: String?
    @Published var role: String?
    
//    var dataHolder: DataHolder // Khai báo một biến để lưu trữ DataHolder
//
//    init(dataHolder: DataHolder) { // Khởi tạo dataHolder từ bên ngoài
//        self.dataHolder = dataHolder
//    }

  
    

    func getUser(tokenLogin: String){
        guard let url = URL(string: "\(DataHolder.url)/api/v1/users/info") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(tokenLogin)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Error fetching")
                return 
            }
            do{
                let decodedData = try JSONDecoder().decode(Userdata.self, from: data)
                DispatchQueue.main.async {
                    self.user = decodedData.data
                    self.balance = decodedData.data.balance
                    self.id = decodedData.data.id
                    self.firstName = decodedData.data.firstName
                    self.lastName = decodedData.data.lastName
                    self.phoneNumber = decodedData.data.phoneNumber
                    self.email = decodedData.data.email
                    self.role = decodedData.data.role
                }
            } catch{
                print(error)
            }
        }.resume()
    }
}
