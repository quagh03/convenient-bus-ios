//
//  VehicleAPI.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 25/04/2024.
//

import Foundation
import SwiftUI

class VehicleAPI:ObservableObject{
    @Published var allVehicle: [Vehicle] = []
    
    func getAllVehicle(tokenLogin: String){
        guard let url = URL(string: "\(DataHolder.url)/api/v1/vehicles") else {
            print("Invalid url vehicle")
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(tokenLogin)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Invalid response vehicle")
                return
            }
            
            do{
                let decodedData = try JSONDecoder().decode(VehicleData.self, from: data)
                DispatchQueue.main.async {
                    self.allVehicle = decodedData.data
                }
            }catch{
                print(error)
            }
        }.resume()
    }
}
