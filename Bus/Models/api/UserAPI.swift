//
//  UserAPI.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 10/04/2024.
//

import Foundation

class UserAPI: ObservableObject {
    @Published var user: User?
    @Published var balance: Float?
    @Published var id : Int?

    func getUser(tokenLogin: String){
        guard let url = URL(string: "http://localhost:8080/api/v1/users/info") else {
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
                }
            } catch{
                print(error)
            }
        }.resume()
    }
}
