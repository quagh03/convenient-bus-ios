//
//  DutyAPI.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 21/04/2024.
//

import Foundation
import SwiftUI

class DutyAPI:ObservableObject{
    @Published var sessionId: Int?
    
    @Published var isStart: Bool = false
//    @Published var sessionID: Int?
    
    
    func startSession(driverID:Int, routeID: Int, vehicleID:Int, tokenLogin: String){
        guard let url = URL(string: "\(DataHolder.url)/api/v1/duty_sessions") else {
            print("Invalid url")
            return
        }
        
        let dutyData: [String: Any] = [
            "driver_id": driverID,
            "route_id": routeID,
            "vehicle_id": vehicleID
        ]
        
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: dutyData)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
            request.addValue("Bearer \(tokenLogin)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response")
                    return
                }
                if httpResponse.statusCode == 200 {
                    print("Start")
                    if let responseData = data {
                        do{
                            let decodedData = try JSONDecoder().decode(SessionData.self, from: responseData)
                            DispatchQueue.main.async {
                                self.isStart = true
                                self.sessionId = decodedData.data.id
                            }
                        } catch {
                            print(error)
                        }
                    }
                } else {
                    print("Start failed")
                }
            }.resume()
        }catch{
            print(error)
        }
    }
    
    func finishSession(id:Int, tokenLogin: String){
        guard let url = URL(string: "\(DataHolder.url)/api/v1/duty_sessions/end?id=\(id)") else {
            print("Invalid url")
            return
        }
        
        do{
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
            request.addValue("Bearer \(tokenLogin)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response")
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    print("Close session")
                    DispatchQueue.main.async {
                        self.isStart = false
                    }
                } else {
                    print("Close failed")
                }
            }.resume()
        }
        
    }
}
