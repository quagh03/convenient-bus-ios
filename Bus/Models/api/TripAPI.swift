//
//  TripAPI.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 29/04/2024.
//

import Foundation
import SwiftUI

class TripAPI: ObservableObject{
    
    @Published var trip: [Trip] = []
    
    
    func getTripForUser(tokenLogin: String){
        guard let url = URL(string: "\(DataHolder.url)/api/v1/trip_history/user") else {
            print("Invalid url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(tokenLogin)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response ,error in
            guard let data = data else {
                print("Invalid response duty" )
                return
            }
            do{
                let decodedData = try JSONDecoder().decode(TripData.self, from: data)
                DispatchQueue.main.async {
                    self.trip = decodedData.data
                }
            }catch{
                print(error)
            }
        }.resume()
    }
    
}
