//
//  busRoutes_api.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 27/03/2024.
//

import Foundation

class BusRoutesApi:ObservableObject{
    @Published var busRoutes: [BusRoute] = []
    
    func fetchData(){
        guard let url = URL(string: "http://localhost:8080/api/v1/bus_routes/all") else {
            print("Invalid url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, respone, error in
            guard let data = data, error == nil else{
                print("Error fetching")
                return
            }
            
            do{
                let decodedData = try JSONDecoder().decode(BusRouteData.self, from: data)
                DispatchQueue.main.async {
//                    self.busRoutes = decodedData
                    self.busRoutes = decodedData.data
                }
            } catch{
                print(String(describing: error))
            }
        }.resume()
    }
}
