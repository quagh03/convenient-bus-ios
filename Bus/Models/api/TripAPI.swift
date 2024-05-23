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
    @Published var isAddTripSuccessful: Bool = false

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
    
    func addTrip(tokenLogin: String ,dutyID: Int, username: String, completion: @escaping (Bool) -> Void){
        guard let url = URL(string: "\(DataHolder.url)/api/v1/trip_history?duty_id=\(dutyID)&username=\(username)") else {
            print("Invalid url ")
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(tokenLogin)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                // Xử lý lỗi tại đây nếu cần
                return
            }
            
            guard let httpResonse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if httpResonse.statusCode == 200 {
                print("add trip successfully")
                self.isAddTripSuccessful = true
                completion(true)
            } else {
                print("add trip failed")
                self.isAddTripSuccessful = false
                completion(false)
            }
        }.resume()
        
    }
    
}
