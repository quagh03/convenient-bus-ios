//
//  LoginApi.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 29/03/2024.
//

import Foundation

class LoginApi: ObservableObject {
    @Published var userLog: User?
    @Published var qrCode: QRCode?
    var tokenLogin: String?
    var code: String?
    
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
                
                guard let data = data else {
                    print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    print("Đăng nhập thành công")
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
                            if let token = json["token"] as? String {
                                self.tokenLogin = token
                            } else{
                                print("không có token")
                            }
                        }
                    } catch {
                        print("Failed to decode JSON")
                    }
                } else {
                    print("Login successfully!")
                }
            }.resume()
            
        } catch let error {
            print("Failed to serialize body:", error)
            return
        }
    }
    
    func fetchQRCode(token: String){
        guard let url = URL(string: "http://localhost:8080/api/v1/users/QRCode") else {
            print("Invalid url")
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Error fetching")
                return
            }
            
            do{
                let decodedResponse = try JSONDecoder().decode(QRCode.self, from: data)
                DispatchQueue.main.async {
                    self.code = decodedResponse.data
                    print(self.code!)
                }
            } catch{
                print(error)
            }
        }
        
    }
}
