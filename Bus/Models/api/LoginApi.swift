//
//  LoginApi.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 29/03/2024.
//

import Foundation

class LoginApi: ObservableObject {
    @Published var userLog: user?
    
    func login(username: String, password: String){
        guard let url = URL(string: "http://localhost:8080/api/v1/users/login") else {
            print("Invalid url")
            return
        }
        
        let body: [String: String] = [
            "username": username,
            "password": password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response")
                    return
                }
                if httpResponse.statusCode == 200 {
                    print("Đăng nhập thành công")
                } else {
                    print("Đăng nhập không thành công!")
                }
            }.resume()
            
        } catch let error {
            print("Failed to serialize body:", error)
            return
        }
        
        
        
    }
}
