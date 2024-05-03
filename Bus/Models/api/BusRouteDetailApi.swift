//
//  BusRouteDetail.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 29/03/2024.
//

import Foundation
import SwiftUI

class BusRoutesDetailApi:ObservableObject{
    @EnvironmentObject var dataHolder: DataHolder
    
    @Published var busRouteDetail: [BusRouteDetail] = []
    
    @Published var departureRoutes: [BusRouteDetail] = []
    @Published var returnRoutes: [BusRouteDetail] = []
    @Published var inforDeparture: [BusRouteDetail] = []
    @Published var inforReturn: [BusRouteDetail] = []
    
    
    
    func fetchData(nameRoute: String){
        guard let url = URL(string: "\(DataHolder.url)/api/v1/route_details/route?name=\(nameRoute)") else {
            print("Invalid url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, respone, error in
            guard let data = data, error == nil else{
                print("Error fetching")
                return
            }
            
            do{
                let decodedData = try JSONDecoder().decode(BusRouteDataDetail.self, from: data)
                DispatchQueue.main.async {
                    self.busRouteDetail = decodedData.data

                    self.departureRoutes = decodedData.data.filter { $0.direction == "DEPARTURE"}
                    self.returnRoutes = decodedData.data.filter { $0.direction == "RETURN" }
                    self.inforDeparture = decodedData.data.filter { $0.direction == "DEPARTURE" }
                    self.inforReturn = decodedData.data.filter { $0.direction == "RETURN" }
                }
            } catch{
                print(String(describing: error))
            }
        }.resume()
    }
}


