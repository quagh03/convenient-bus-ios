//
//  busRoutes_api.swift
//  Bus
//
//  Created by Nguyễn Hữu Hiếu on 27/03/2024.
//

import Foundation
import SwiftUI

class BusRoutesApi:ObservableObject{
    
    @Published var busRoutes: [BusRoute] = []
    @Published var busRouteFavorite: [BusRoute] = []
    var favoriteIDs: Set<Int> = []
    
//    @EnvironmentObject var dataHolder: DataHolder
    
    func fetchData(){
        guard let url = URL(string: "\(DataHolder.url)/api/v1/bus_routes/all") else {
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
                    self.busRouteFavorite = decodedData.data.filter{self.favoriteIDs.contains($0.id)}
                    
                }
            } catch{
                print(String(describing: error))
            }
        }.resume()
    }
}
